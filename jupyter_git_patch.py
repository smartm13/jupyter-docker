

# jupyter-git-patch start

def copy2_safe(src, dst, log=None):
    """copy src to dst

    like shutil.copy2, but log errors in copystat instead of raising
    """
    shutil.copyfile(src, dst)
    try:
        if dst.count('{0}.ipynb_checkpoints{0}'.format(os.sep)):
            chkpoint = dst.split(__import__("os").sep)[-1]
            ipydir = dst.rstrip(chkpoint)
            r = 0
            try:
                r = __import__("git").Repo(ipydir)
            except __import__("git").exc.InvalidGitRepositoryError:
                r = __import__("git").Repo.init(ipydir)
            if [1 for d in r.index.diff(None) if chkpoint in d.a_path] or chkpoint in r.untracked_files:
                saviuser,saviuserr = "defaulter","defaulterr"
                try:
                    frameno=4#py3
                    saviuser = __import__("inspect").getouterframes(__import__("inspect").currentframe())[frameno][0].f_locals['self'].request.remote_ip
                    saviuserr = __import__("socket").gethostbyaddr(saviuser)[0]
                except Exception as e:
                    print("Attempt remote user detection: py3 failed:{} Trying py2 now.".format(e))
                    try:
                        frameno=10#py2
                        saviuser = __import__("inspect").getouterframes(__import__("inspect").currentframe())[frameno][0].f_locals['self'].request.remote_ip
                        saviuserr = __import__("socket").gethostbyaddr(saviuser)[0]
                    except Exception as e2:
                        print("Failed in remote user detection:", e2)
                r.config_writer().set_value("user", "name", saviuserr).release()
                r.config_writer().set_value("user", "email", saviuser).release()
                try:
                    r.git.add(chkpoint)
                except (__import__("git").exc.GitCommandError, IOError):
                    if sum(__import__("traceback").format_exc().count(_c) for _c in "Unable to create,index.lock,: File exists.".split(','))>2:
                        # index.lock needs to be deleted.
                        __import__("time").sleep(1)
                        to_delete=__import__("os").sep.join([ipydir, ".git", "index.lock"])
                        __import__("os").remove(to_delete)
                        print("Git commit: Deleted older existing git-locks.. Retrying to commit..[{}]".format(to_delete))
                    r.git.add(chkpoint)
                r.index.commit(chkpoint.rstrip('checkpoint.ipynb') + __import__("datetime").datetime.now().isoformat())
    except Exception as e:
        print ("Git commiting failed as:", e,'\n',__import__("traceback").format_exc())
    try:
        shutil.copystat(src, dst)
    except OSError:
        if log:
            log.debug("copystat on %s failed", dst, exc_info=True)


# jupyter-git-patch end



Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E584DF5
	for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644229; cv=none; b=F7uJWLbVhd/LhmUmFpPgEYr/jZlSLa2YJe2d8Tg2ysiuWiZzTMfYoZkdnBrUrIl9kLnrLlQKXIiN4ZlRuRcBWBVpnIlaGgkBF4FNXqHKRCkjlvfekXmR40YsdPiwsQFxd0WOEdSaIPBZXcoyPtxVPssJWcQ7t8wMZNcF48I0x/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644229; c=relaxed/simple;
	bh=jabLpUywj9mXHcjULb4WKpzqpVQcaeWIMySbgxjnxi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXDAZtTKOi7gjTM+r72m/ZO0M87S8bVLfM1gMOLR+cWqzrPP9vPpWgoADVF/+RMZSXfAb1Orci9AOJGt9a56Cv2M3vQ0Pjrv8I1L+X3nb6Qz6NJ1iPBBm8gaxzex3qAR2YKMvrp/FbbEVqQjxi2jJ13/J6CdXtGGwCMxcp06iKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EP/a1jCa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EP/a1jCa"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b4952a1aecso3348400a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715644225; x=1716249025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HkwG0xAsY0LmcCu7366TLsdMJMye5dnEFWq92mCE/g=;
        b=EP/a1jCavQP7/vtImxx1GMoFn6hqxJ0lE0ObXSsb+ShWRslI4lafy3cBW49oRol60Z
         j2S+j4dl5YVWv+EFDDWjdUcVNHrCkLjwLaJttd9v1ydMIkiCWBVuEeEMUnrqVxrQnz9g
         txPjS/QCxnl61hSlEXYe27BrYlE7xO8njlDjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715644225; x=1716249025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HkwG0xAsY0LmcCu7366TLsdMJMye5dnEFWq92mCE/g=;
        b=oPATwnNFDJRi0wqWUmHBDKGzAEznNeqDkb3OEaSRA44EGA13NXsI1U59qTwfpmh7XU
         MjmwVIfbzJasokEB8QQH7KKORP5pZE/CH6QMrtr8kNjgdzvxqwH+32mze8lDrnrEgWO6
         cwZkh3VvjmRZJy8FdLyBqFZW+rjretTmFbD0VBdPpfeccYc12FdwYIwp2WHFVqHm9cOy
         jO3RB8+JdbQm/IRt0yc3/t1PjgUubJTeIr0JCBI9ovg2O08vOgko5Wf6Z5pfNDgzQE90
         tA/Uuuc685gkSxZnfaz9Vb0hgSmZSIp2LU0+lEmEYwMHjrrq+jZ8SsoZzqh+udTeFx5z
         7iTg==
X-Forwarded-Encrypted: i=1; AJvYcCUrWMieKSIPKA3H93+LClOlwnW6auiAihH0bK1ULEOUfwyexz4nNVl/t90c8TwwyWTt+7xc6LsMlJoL5lGHGRvIBhiDfJP00Ga46Ibs2qqB
X-Gm-Message-State: AOJu0Yy9GtDZmBpoMqAExHPot2CncNHB8Vj95jX09xX9UJXEmBUiv/nK
	hJIw35vTZu9IK8hEbxGYTrv9CxFd4UWMWCFDEBfKehAIIz+YfRiLS/G2M3HndQ==
X-Google-Smtp-Source: AGHT+IGYhei7jKQWg3kW4q6ciPLQaYeMlYBwnGN1HFp6GQz0KvB+mNLvPf0P9zQEFJVwFP2dlfQzBA==
X-Received: by 2002:a17:90a:b796:b0:2b1:dd0e:e20 with SMTP id 98e67ed59e1d1-2b6ccb7e5f8mr9202653a91.38.1715644224543;
        Mon, 13 May 2024 16:50:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671056613sm9392889a91.4.2024.05.13.16.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:50:23 -0700 (PDT)
Date: Mon, 13 May 2024 16:50:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com,
	inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v3 1/2] proc: restrict /proc/pid/mem access via param
 knobs
Message-ID: <202405131641.219CD40A62@keescook>
References: <20240409175750.206445-1-adrian.ratiu@collabora.com>
 <202404261544.1EAD63D@keescook>
 <20240503-nulltarif-karten-82213463dedc@brauner>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-nulltarif-karten-82213463dedc@brauner>

On Fri, May 03, 2024 at 11:57:56AM +0200, Christian Brauner wrote:
> On Fri, Apr 26, 2024 at 04:10:49PM -0700, Kees Cook wrote:
> > On Tue, Apr 09, 2024 at 08:57:49PM +0300, Adrian Ratiu wrote:
> > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > "no longer a security hazard". :)
> > > 
> > > Afterwards exploits started causing drama like [1]. The exploits
> > > using /proc/*/mem can be rather sophisticated like [2] which
> > > installed an arbitrary payload from noexec storage into a running
> > > process then exec'd it, which itself could include an ELF loader
> > > to run arbitrary code off noexec storage.
> > > 
> > > One of the well-known problems with /proc/*/mem writes is they
> > > ignore page permissions via FOLL_FORCE, as opposed to writes via
> > > process_vm_writev which respect page permissions. These writes can
> > > also be used to bypass mode bits.
> > > 
> > > To harden against these types of attacks, distrbutions might want
> > > to restrict /proc/pid/mem accesses, either entirely or partially,
> > > for eg. to restrict FOLL_FORCE usage.
> > > 
> > > Known valid use-cases which still need these accesses are:
> > > 
> > > * Debuggers which also have ptrace permissions, so they can access
> > > memory anyway via PTRACE_POKEDATA & co. Some debuggers like GDB
> > > are designed to write /proc/pid/mem for basic functionality.
> > > 
> > > * Container supervisors using the seccomp notifier to intercept
> > > syscalls and rewrite memory of calling processes by passing
> > > around /proc/pid/mem file descriptors.
> > > 
> > > There might be more, that's why these params default to disabled.
> > > 
> > > Regarding other mechanisms which can block these accesses:
> > > 
> > > * seccomp filters can be used to block mmap/mprotect calls with W|X
> > > perms, but they often can't block open calls as daemons want to
> > > read/write their runtime state and seccomp filters cannot check
> > > file paths, so plain write calls can't be easily blocked.
> > > 
> > > * Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > > can't run chmod once at boot to restrict it (and trying to react
> > > to every process and run chmod doesn't scale, and the kernel no
> > > longer allows chmod on any of these paths).
> > > 
> > > * SELinux could be used with a rule to cover all /proc/*/mem files,
> > > but even then having multiple ways to deny an attack is useful in
> > > case one layer fails.
> > > 
> > > Thus we introduce three kernel parameters to restrict /proc/*/mem
> > > access: read, write and foll_force. All three can be independently
> > > set to the following values:
> > > 
> > > all     => restrict all access unconditionally.
> > > ptracer => restrict all access except for ptracer processes.
> > > 
> > > If left unset, the existing behaviour is preserved, i.e. access
> > > is governed by basic file permissions.
> > > 
> > > Examples which can be passed by bootloaders:
> > > 
> > > restrict_proc_mem_foll_force=all
> > > restrict_proc_mem_write=ptracer
> > > restrict_proc_mem_read=ptracer
> > > 
> > > Each distribution needs to decide what restrictions to apply,
> > > depending on its use-cases. Embedded systems might want to do
> > > more, while general-purpouse distros might want a more relaxed
> > > policy, because for e.g. foll_force=all and write=all both break
> > > break GDB, so it might be a bit excessive.
> > > 
> > > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> > 
> > Thanks for this new version!
> > 
> > > 
> > > Link: https://lwn.net/Articles/476947/ [1]
> > > Link: https://issues.chromium.org/issues/40089045 [2]
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  27 +++++
> > >  fs/proc/base.c                                | 103 +++++++++++++++++-
> > >  include/linux/jump_label.h                    |   5 +
> > >  3 files changed, 133 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 6e62b8cb19c8d..d7f7db41369c7 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5665,6 +5665,33 @@
> > >  	reset_devices	[KNL] Force drivers to reset the underlying device
> > >  			during initialization.
> > >  
> > > +	restrict_proc_mem_read= [KNL]
> > > +			Format: {all | ptracer}
> > > +			Allows restricting read access to /proc/*/mem files.
> > > +			Depending on restriction level, open for reads return -EACCESS.
> > > +			Can be one of:
> > > +			- 'all' restricts all access unconditionally.
> > > +			- 'ptracer' allows access only for ptracer processes.
> > > +			If not specified, then basic file permissions continue to apply.
> > > +
> > > +	restrict_proc_mem_write= [KNL]
> > > +			Format: {all | ptracer}
> > > +			Allows restricting write access to /proc/*/mem files.
> > > +			Depending on restriction level, open for writes return -EACCESS.
> > > +			Can be one of:
> > > +			- 'all' restricts all access unconditionally.
> > > +			- 'ptracer' allows access only for ptracer processes.
> > > +			If not specified, then basic file permissions continue to apply.
> > > +
> > > +	restrict_proc_mem_foll_force= [KNL]
> > > +			Format: {all | ptracer}
> > > +			Restricts the use of the FOLL_FORCE flag for /proc/*/mem access.
> > > +			If restricted, the FOLL_FORCE flag will not be added to vm accesses.
> > > +			Can be one of:
> > > +			- 'all' restricts all access unconditionally.
> > > +			- 'ptracer' allows access only for ptracer processes.
> > > +			If not specified, FOLL_FORCE is always used.
> > 
> > bike shedding: I wonder if this should be a fake namespace (adding a dot
> > just to break it up for reading more easily), and have words reordered
> > to the kernel's more common subject-verb-object: proc_mem.restrict_read=...
> > 
> > > +
> > >  	resume=		[SWSUSP]
> > >  			Specify the partition device for software suspend
> > >  			Format:
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index 18550c071d71c..c733836c42a65 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -152,6 +152,41 @@ struct pid_entry {
> > >  		NULL, &proc_pid_attr_operations,	\
> > >  		{ .lsmid = LSMID })
> > >  
> > > +/*
> > > + * each restrict_proc_mem_* param controls the following static branches:
> > > + * key[0] = restrict all writes
> > > + * key[1] = restrict writes except for ptracers
> > > + * key[2] = restrict all reads
> > > + * key[3] = restrict reads except for ptracers
> > > + * key[4] = restrict all FOLL_FORCE usage
> > > + * key[5] = restrict FOLL_FORCE usage except for ptracers
> > > + */
> > > +DEFINE_STATIC_KEY_ARRAY_FALSE_RO(restrict_proc_mem, 6);
> > 
> > So, I don't like having open-coded numbers. And I'm not sure there's a
> > benefit to stuffing these all into an array? So:
> > 
> > DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_read);
> > DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_write);
> > DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_foll_force);
> > 
> > > +
> > > +static int __init early_restrict_proc_mem(char *buf, int offset)
> > > +{
> > > +	if (!buf)
> > > +		return -EINVAL;
> > > +
> > > +	if (strncmp(buf, "all", 3) == 0)
> > 
> > I'd use strcmp() to get exact matches. That way "allalksdjflas" doesn't
> > match. :)
> > 
> > > +		static_branch_enable(&restrict_proc_mem[offset]);
> > > +	else if (strncmp(buf, "ptracer", 7) == 0)
> > > +		static_branch_enable(&restrict_proc_mem[offset + 1]);
> > > +
> > > +	return 0;
> > > +}
> > 
> > Then don't bother with a common helper since you've got a macro, and
> > it'll all get tossed after __init anyway.
> > 
> > > +
> > > +#define DEFINE_EARLY_RESTRICT_PROC_MEM(name, offset)			\
> > > +static int __init early_restrict_proc_mem_##name(char *buf)		\
> > > +{									\
> > > +	return early_restrict_proc_mem(buf, offset);			\
> > > +}									\
> > > +early_param("restrict_proc_mem_" #name, early_restrict_proc_mem_##name)
> > > +
> > > +DEFINE_EARLY_RESTRICT_PROC_MEM(write, 0);
> > > +DEFINE_EARLY_RESTRICT_PROC_MEM(read, 2);
> > > +DEFINE_EARLY_RESTRICT_PROC_MEM(foll_force, 4);
> > 
> > #define DEFINE_EARLY_PROC_MEM_RESTRICT(name)				\
> > static int __init early_proc_mem_restrict_##name(char *buf)		\
> > {									\
> > 	if (!buf)							\
> > 		return -EINVAL;						\
> > 									\
> > 	if (strcmp(buf, "all") == 0)					\
> > 		static_branch_enable(&proc_mem_restrict_##name);	\
> > 	else if (strcmp(buf, "ptracer") == 0)				\
> > 		static_branch_enable(&proc_mem_restrict_##name);	\
> > 									\
> > 	return 0;							\
> > }									\
> > early_param("proc_mem_restrict_" #name, early_proc_mem_restrict_##name)
> > 
> > 
> > > +
> > >  /*
> > >   * Count the number of hardlinks for the pid_entry table, excluding the .
> > >   * and .. links.
> > > @@ -825,9 +860,58 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> > >  	return 0;
> > >  }
> > >  
> > > +static bool __mem_open_current_is_ptracer(struct file *file)
> > > +{
> > > +	struct inode *inode = file_inode(file);
> > > +	struct task_struct *task = get_proc_task(inode);
> > > +	int ret = false;
> > > +
> > > +	if (task) {
> > > +		rcu_read_lock();
> > > +		if (current == ptrace_parent(task))
> > > +			ret = true;
> > > +		rcu_read_unlock();
> > > +		put_task_struct(task);
> > > +	}
> > 
> > This creates a ToCToU race between this check (which releases the task)
> > and the later memopen which make get a different task (and mm).
> > 
> > To deal with this, I think you need to add a new mode flag for
> > proc_mem_open(), and add the checking there.
> > 
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int __mem_open_check_access_restriction(struct file *file)
> > > +{
> > > +	if (file->f_mode & FMODE_WRITE) {
> > > +		/* Deny if writes are unconditionally disabled via param */
> > > +		if (static_branch_unlikely(&restrict_proc_mem[0]))
> > > +			return -EACCES;
> > > +
> > > +		/* Deny if writes are allowed only for ptracers via param */
> > > +		if (static_branch_unlikely(&restrict_proc_mem[1]) &&
> > > +		    !__mem_open_current_is_ptracer(file))
> > > +			return -EACCES;
> > > +
> > > +	} else if (file->f_mode & FMODE_READ) {
> > 
> > I think this "else" means that O_RDWR opens will only check the write
> > flag, so drop the "else".
> > 
> > > +		/* Deny if reads are unconditionally disabled via param */
> > > +		if (static_branch_unlikely(&restrict_proc_mem[2]))
> > > +			return -EACCES;
> > > +
> > > +		/* Deny if reads are allowed only for ptracers via param */
> > > +		if (static_branch_unlikely(&restrict_proc_mem[3]) &&
> > > +		    !__mem_open_current_is_ptracer(file))
> > > +			return -EACCES;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int mem_open(struct inode *inode, struct file *file)
> > >  {
> > > -	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> > > +	int ret;
> > > +
> > > +	ret = __mem_open_check_access_restriction(file);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> > >  
> > >  	/* OK to pass negative loff_t, we can catch out-of-range */
> > >  	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> > > @@ -835,6 +919,20 @@ static int mem_open(struct inode *inode, struct file *file)
> > >  	return ret;
> > >  }
> > >  
> > > +static unsigned int __mem_rw_get_foll_force_flag(struct file *file)
> > > +{
> > > +	/* Deny if FOLL_FORCE is disabled via param */
> > > +	if (static_branch_unlikely(&restrict_proc_mem[4]))
> > > +		return 0;
> > > +
> > > +	/* Deny if FOLL_FORCE is allowed only for ptracers via param */
> > > +	if (static_branch_unlikely(&restrict_proc_mem[5]) &&
> > > +	    !__mem_open_current_is_ptracer(file))
> > 
> > This is like the ToCToU: the task may have changed out from under us
> > between the open the read/write.
> 
> But why would you care? As long as the task is the ptracer it doesn't
> really matter afaict.

Because the mm you're writing to may no longer be associated with the
task.

proc_mem_operations.open() will take a reference to the current task's
mm, via proc_mem_open() through __mem_open():

        struct task_struct *task = get_proc_task(inode);
	...
	mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
	...
	file->private_data = mm;


And in the proposed check added to mem_rw(), if get_proc_task(inode)
returns a different task (i.e. the pid got recycled and the original mm
is still associated with a forked task), then it could write to the
forked task using the ptrace check against the new task.

Looking at it again now, I think it should be possible to just revalidate
the mm in __mem_open_current_is_ptracer(), though. i.e. it would be
allowed if ptrace check passes and file->private_data == mm_access(...),
for the mem_rw case...

-- 
Kees Cook

Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0314BC4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 16:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiLHQ1O (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiLHQ1E (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 11:27:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F26E54D
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 08:27:02 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w37so1576265pga.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lh+BTg81soVr+6LzeJ2EjyFbH2jfE8Jb6jdCOQpIEs=;
        b=DIt8YjYLc0xFCDPfw1Lw7trfvvmJVfLf3tbVp+MOv4p+gDV3qSW8hpIllyH3D/iAVb
         bKq4FcwS5F96gVeKpHTemDe51zgq7iQbixfvk819Rpq6ehz01tUmK0FERmnoStBi2WMX
         6XtN+1lurNUxjL/FWvh3/eNatm0QemovgNND4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lh+BTg81soVr+6LzeJ2EjyFbH2jfE8Jb6jdCOQpIEs=;
        b=Nq1km74v8VF4G3Ev5RV11bACMztz3nc/ArGVN7W/fOZuque9EgqX64Ic14olylIWZj
         dXELu87Ja/T3ilSZg/y4sOFxuvcFi39LLVdOeK33ngUu1iz9Kr0LkVWBRU8upCO+K2Tk
         5T2kTCfIn9gsSCWIK0SYmady2OHilkqC/PKSSlin5akrdtz94/oRLCt1H9P8RCHxXIAW
         QdVM3fAqy0mjsCPC7FV/PRm3h289+BUFwAm1n9yPxZJNsSg49y/4EtMwSqJRBF08dYR1
         RCpsfK+eNgB0MJasoySRWflrWdY4+1FT+VPC5xTT/wPynWGdy4OmZ5qWNBOkWuKI7WGg
         r+9A==
X-Gm-Message-State: ANoB5pmxM7T7gh0scyEtvlwJULSKhUUNsAq9cX/AmIJRwTLFFRy9Kfu4
        LH9Op837kt1ZaWwsDZ5FKMrsNw==
X-Google-Smtp-Source: AA0mqf6Xr6hLzp/usF6hIGA8rv4AdkSlLfhKsnnSzQoxC/SeedquZho16Iu7SkOY+sazrrQNl421pA==
X-Received: by 2002:a05:6a02:108:b0:46b:3acb:77ab with SMTP id bg8-20020a056a02010800b0046b3acb77abmr67350434pgb.359.1670516822007;
        Thu, 08 Dec 2022 08:27:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u68-20020a626047000000b0057716769289sm6867426pfb.196.2022.12.08.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:27:01 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:27:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212080821.5AE7EE99@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-4-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-4-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:36PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
> set executable bit at creation time (memfd_create).
> 
> When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> (mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> be executable (mode: 0777) after creation.
> 
> when MFD_EXEC flag is set, memfd is created with executable bit
> (mode:0777), this is the same as the old behavior of memfd_create.
> 
> The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> 	MFD_EXEC was set.
> 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> 	MFD_NOEXEC_SEAL was set.
> 2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> 
> The sysctl allows finer control of memfd_create for old-software
> that doesn't set the executable bit, for example, a container with
> vm.memfd_noexec=1 means the old-software will create non-executable
> memfd by default. Also, the value of memfd_noexec is passed to child
> namespace at creation time. For example, if the init namespace has
> vm.memfd_noexec=2, all its children namespaces will be created with 2.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>

Please rearrange these tags, and add a link to the lkp report:

  Reported-by: kernel test robot <lkp@intel.com>
  Link: ...url.to.lkp.lore.email...
  Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
  Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
  Signed-off-by: Jeff Xu <jeffxu@google.com>

> ---
>  include/linux/pid_namespace.h | 19 +++++++++++
>  include/uapi/linux/memfd.h    |  4 +++
>  kernel/pid_namespace.c        |  5 +++
>  kernel/pid_sysctl.h           | 59 +++++++++++++++++++++++++++++++++++
>  mm/memfd.c                    | 48 ++++++++++++++++++++++++++--
>  5 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/pid_sysctl.h
> 
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 07481bb87d4e..a4789a7b34a9 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -16,6 +16,21 @@
>  
>  struct fs_pin;
>  
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> +/*
> + * sysctl for vm.memfd_noexec
> + * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
> + *	acts like MFD_EXEC was set.
> + * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
> + *	acts like MFD_NOEXEC_SEAL was set.
> + * 2: memfd_create() without MFD_NOEXEC_SEAL will be
> + *	rejected.
> + */
> +#define MEMFD_NOEXEC_SCOPE_EXEC		0
> +#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1
> +#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2

These don't align? I think a tab is missing on MEMFD_NOEXEC_SCOPE_EXEC.

> +#endif
> +
>  struct pid_namespace {
>  	struct idr idr;
>  	struct rcu_head rcu;
> @@ -31,6 +46,10 @@ struct pid_namespace {
>  	struct ucounts *ucounts;
>  	int reboot;	/* group exit code if this pidns was rebooted */
>  	struct ns_common ns;
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> +	/* sysctl for vm.memfd_noexec */
> +	int memfd_noexec_scope;
> +#endif
>  } __randomize_layout;
>  
>  extern struct pid_namespace init_pid_ns;
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 7a8a26751c23..273a4e15dfcf 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -8,6 +8,10 @@
>  #define MFD_CLOEXEC		0x0001U
>  #define MFD_ALLOW_SEALING	0x0002U
>  #define MFD_HUGETLB		0x0004U
> +/* not executable and sealed to prevent changing to executable. */
> +#define MFD_NOEXEC_SEAL		0x0008U
> +/* executable */
> +#define MFD_EXEC		0x0010U
>  
>  /*
>   * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index f4f8cb0435b4..8a98b1af9376 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -23,6 +23,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/signal.h>
>  #include <linux/idr.h>
> +#include "pid_sysctl.h"
>  
>  static DEFINE_MUTEX(pid_caches_mutex);
>  static struct kmem_cache *pid_ns_cachep;
> @@ -110,6 +111,8 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
>  
> +	initialize_memfd_noexec_scope(ns);
> +
>  	return ns;
>  
>  out_free_idr:
> @@ -455,6 +458,8 @@ static __init int pid_namespaces_init(void)
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	register_sysctl_paths(kern_path, pid_ns_ctl_table);
>  #endif
> +
> +	register_pid_ns_sysctl_table_vm();
>  	return 0;
>  }
>  
> diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
> new file mode 100644
> index 000000000000..5986d6493b5b
> --- /dev/null
> +++ b/kernel/pid_sysctl.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_PID_SYSCTL_H
> +#define LINUX_PID_SYSCTL_H
> +
> +#include <linux/pid_namespace.h>
> +
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> +static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns)
> +{
> +	ns->memfd_noexec_scope =
> +		task_active_pid_ns(current)->memfd_noexec_scope;
> +}
> +
> +static int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table,
> +	int write, void *buf, size_t *lenp, loff_t *ppos)
> +{
> +	struct pid_namespace *ns = task_active_pid_ns(current);
> +	struct ctl_table table_copy;
> +
> +	if (write && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;

Should this be CAP_SYS_ADMIN within the userns, rather than the global
init_task CAP_SYS_ADMIN?

> +
> +	table_copy = *table;
> +	if (ns != &init_pid_ns)
> +		table_copy.data = &ns->memfd_noexec_scope;
> +
> +	/*
> +	 * set minimum to current value, the effect is only bigger
> +	 * value is accepted.
> +	 */
> +	if (*(int *)table_copy.data > *(int *)table_copy.extra1)
> +		table_copy.extra1 = table_copy.data;
> +
> +	return proc_dointvec_minmax(&table_copy, write, buf, lenp, ppos);
> +}
> +
> +static struct ctl_table pid_ns_ctl_table_vm[] = {
> +	{
> +		.procname	= "memfd_noexec",
> +		.data		= &init_pid_ns.memfd_noexec_scope,
> +		.maxlen		= sizeof(init_pid_ns.memfd_noexec_scope),
> +		.mode		= 0644,
> +		.proc_handler	= pid_mfd_noexec_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_TWO,
> +	},
> +	{ }
> +};
> +static struct ctl_path vm_path[] = { { .procname = "vm", }, { } };
> +static inline void register_pid_ns_sysctl_table_vm(void)
> +{
> +	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
> +}
> +#else
> +static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
> +static inline void register_pid_ns_ctl_table_vm(void) {}
> +#endif
> +
> +#endif /* LINUX_PID_SYSCTL_H */
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 4ebeab94aa74..ec70675a7069 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -18,6 +18,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/memfd.h>
> +#include <linux/pid_namespace.h>
>  #include <uapi/linux/memfd.h>
>  
>  /*
> @@ -263,12 +264,14 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
>  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>  
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
>  
>  SYSCALL_DEFINE2(memfd_create,
>  		const char __user *, uname,
>  		unsigned int, flags)
>  {
> +	char comm[TASK_COMM_LEN];

I'm fine with using "comm", but technically, it's not needed: task->comm
will always be %NUL terminated.

> +	struct pid_namespace *ns;
>  	unsigned int *file_seals;
>  	struct file *file;
>  	int fd, error;
> @@ -285,6 +288,39 @@ SYSCALL_DEFINE2(memfd_create,
>  			return -EINVAL;
>  	}
>  
> +	/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
> +	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
> +		return -EINVAL;
> +
> +	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> +#ifdef CONFIG_SYSCTL
> +		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
> +
> +		ns = task_active_pid_ns(current);
> +		if (ns)
> +			sysctl = ns->memfd_noexec_scope;
> +
> +		switch (sysctl) {
> +		case MEMFD_NOEXEC_SCOPE_EXEC:
> +			flags |= MFD_EXEC;
> +			break;
> +		case MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL:
> +			flags |= MFD_NOEXEC_SEAL;
> +			break;
> +		default:
> +			pr_warn_ratelimited(
> +				"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
> +				task_pid_nr(current), get_task_comm(comm, current));
> +			return -EINVAL;
> +		}
> +#else
> +		flags |= MFD_EXEC;
> +#endif
> +		pr_warn_ratelimited(
> +			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
> +			task_pid_nr(current), get_task_comm(comm, current));
> +	}
> +
>  	/* length includes terminating zero */
>  	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
>  	if (len <= 0)
> @@ -328,7 +364,15 @@ SYSCALL_DEFINE2(memfd_create,
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>  	file->f_flags |= O_LARGEFILE;
>  
> -	if (flags & MFD_ALLOW_SEALING) {
> +	if (flags & MFD_NOEXEC_SEAL) {
> +		struct inode *inode = file_inode(file);
> +
> +		inode->i_mode &= ~0111;
> +		file_seals = memfd_file_seals_ptr(file);
> +		*file_seals &= ~F_SEAL_SEAL;
> +		*file_seals |= F_SEAL_EXEC;
> +	} else if (flags & MFD_ALLOW_SEALING) {
> +		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
>  		file_seals = memfd_file_seals_ptr(file);
>  		*file_seals &= ~F_SEAL_SEAL;
>  	}
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

Otherwise looks good!

-- 
Kees Cook

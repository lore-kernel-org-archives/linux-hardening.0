Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866A1DE2A6
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181238; cv=none; b=FtRKweGaAMD419ofYQfferMgewZrvGN5iUbE0zk7wwvo/p1dNh4iqWBsEjqriKrPPLDfYp8M8B13uZv35qbNrITo4Qrw0jG9lt1UjHGvR+3XoIO/VUza6vq2roWDvxzYfmYInpyx6EVQRRoP3+/9nYIvKLS4IpIVwpBfAypSCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181238; c=relaxed/simple;
	bh=tjOnkERoystJ4ZvkQYkRMfbPj3TPf5lj/0hjLdkO4PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aon3zH0FSHWmG6Za9OcyI82eiL+Q/Vcss8iC9mb6cktLtNA4Xs+y/t7cuCLrsgDo0Ve2nEItJAYoB+P04k3/73yCUyvJdlPIsaiYKbaIU11Wyj293s6L7lTQmlKYyTkBb/fbKsO9LWoOkoN4c33Ns6rfk4Wfgos6C1eIUTGq6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhcvBeil; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhcvBeil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E98C4CEC3;
	Thu, 17 Oct 2024 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181237;
	bh=tjOnkERoystJ4ZvkQYkRMfbPj3TPf5lj/0hjLdkO4PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhcvBeili7ufVkNQrNV6YP7fIfYWkwdVE5LUiQ6UtZRFrlr034utPFLuBDVrkJ3T2
	 TfA2RUNOxot+Gc81/MbXssQgXxxOfed30ZfzEKivkJQnH1Z2W+cKgDkmKWZRENY+ws
	 BRI5fhab8nc4E5u8Tp9OO/ADQUYzVZa3v+q1SovuLL1fAj65UBQFF0lWqsqr0hf4me
	 toif+1NJMAoFJo7RaxRV1M0tuMzVekkLg7ktDsZ57ZKKA3bU2CzeYHG8kcO5Wo4HUC
	 Fqy7kabYzRX7A3Et14/4LB5B9sNTXsVKaWBCyMk33PFhjJQrjwLeWLn+8m4V9QR551
	 DE8PG1ThYhX8A==
Date: Thu, 17 Oct 2024 09:07:13 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: Fwd: [linux-next:master 4380/4439]
 include/linux/fortify-string.h:293:17: error: call to '__write_overflow'
 declared with attribute error: detected write beyond size of object (1st
 parameter)
Message-ID: <202410170847.F6C111256F@keescook>
References: <202410171420.1V00ICVG-lkp@intel.com>
 <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>

On Thu, Oct 17, 2024 at 10:48:04AM -0400, Paul Moore wrote:
> I'm not sure why the kernel test robot only sent this to me, but this
> looks to be a strscpy() issue rather than an audit specific issue.
> 
> ---------- Forwarded message ---------
> From: kernel test robot <lkp@intel.com>
> Date: Thu, Oct 17, 2024 at 2:29 AM
> Subject: [linux-next:master 4380/4439]
> include/linux/fortify-string.h:293:17: error: call to
> '__write_overflow' declared with attribute error: detected write
> beyond size of object (1st parameter)
> To: Paul Moore <paul@paul-moore.com>
> Cc: <oe-kbuild-all@lists.linux.dev>
> 
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> head:   15e7d45e786a62a211dd0098fee7c57f84f8c681
> commit: dfdb07df2ab66ff4fd2f82039e871e7ab922dc81 [4380/4439] Merge
> branch 'next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
> config: x86_64-randconfig-005-20241017
> (https://download.01.org/0day-ci/archive/20241017/202410171420.1V00ICVG-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build):
> (https://download.01.org/0day-ci/archive/20241017/202410171420.1V00ICVG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/string.h:390,
>                     from include/linux/bitmap.h:13,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/spinlock.h:63,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from kernel/auditsc.c:37:
>    In function 'sized_strscpy',
>        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~

This is a compile-time bounds check. Let's take a look:

void __audit_ptrace(struct task_struct *t)
{
        struct audit_context *context = audit_context();
	...
        strscpy(context->target_comm, t->comm);


struct audit_context {
	...
        char                target_comm[TASK_COMM_LEN];

struct task_struct {
	...
        char                            comm[TASK_COMM_LEN];

So this should be impossible, since the strscpy() check is:

#define __member_size(p)        __builtin_object_size(p, 1)
...
#define __compiletime_lessthan(bounds, length)  (       \
        __builtin_constant_p((bounds) < (length)) &&    \
        (bounds) < (length)                             \
)
...
        const size_t p_size = __member_size(p);
	...
        if (__compiletime_lessthan(p_size, size))
                __write_overflow();

This test should resolve to:

	if (TASK_COMM_LEN < TASK_COMM_LEN)
                __write_overflow();

I can reproduce this with the randconfig linked above, but not with
allmodconfig nor defconfig+CONFIG_FORTIFY_SOURCE.

Something in the .config is causing the error. (!?) I will start a
CONFIG bisect...

-- 
Kees Cook

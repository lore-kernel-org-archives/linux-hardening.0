Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98011DE4F5
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176501; cv=none; b=aG26L76EbvW8CNMLowcnOQkP/xdw4XcEQXsTZUvB0xTKnNyra6VEeUK6iVHxS5UT4QYTnJRJPBaFEbKFfu94243dG5oRDr6koKH7NpBXS+sqAb9oBJzdEyTkIRO2KwF/OaHEqogWkEY6y5HeIgScSmGDYuh0x4bTTaFjv2XY9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176501; c=relaxed/simple;
	bh=M8C3rglWOd/aqRhGv/TqyRKbSSIEX8lB4OTAqfm+0kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibRAo6GgLXXe2PTO/BEz0AHvahX+dvXJZ7MwdRRa3EcEWFfsWOqjTnei2DATX0Q1W1wUaYxpsbOMxPvNJ1ldC5NGa8HVTSeSmYvwHZEgz0YnF3vroITps/XHCA6gg56heAvjqJaNPq7rsYqiIqZcJiLep5Qxq5Eqnlgnso/WqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MPz8+DFV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MPz8+DFV"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e297bd161e0so947145276.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729176495; x=1729781295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL36/Ywq7gDjC5aDjr25tFDyHfdC1PVNE81KlkibdTg=;
        b=MPz8+DFVIA2PKaG/rPMsXTNS3YaC9pNq5RxOY6EoJeVxIKFeLicfdihKhoL6/izJNt
         Kc/x51kgelrWf9UIJGE1PO0WriAiT55PaVGK43h6q1wXwtqBVqTxjX4kTb1RgMz+ZwFd
         KAiuhQoghFbI4geV0fZWwWf10oWIQd6hBImFzvkQrcY1C9shgOqR+45grbuxk0kT/AaF
         4rpwIJY3lXWlH36raHVOxa0maxsvv1Ma7v1ozUNUlTgyjvOKFuEJzHEi80H6EsmBc4K1
         +RX21xMM7HmkeK1I+cL551mUDtSSTV5ETW+JTBdFucKVeO7qS8gubFFvmA+tJkhNda6X
         Lhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176495; x=1729781295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL36/Ywq7gDjC5aDjr25tFDyHfdC1PVNE81KlkibdTg=;
        b=aIOSmpbO7NYgXawAGOZj++q9N7St6DZ8y53WAKNe2ujzWaYw3MY90b8nBGsd5Eumbw
         OeaQxVSIgwSNIAWqo8c0xOK7punSxVC4qKZTyp7EJ8sKOQA+ix/UJx9M9OfgaTdlFeBr
         HXUSpB2ubHAenP1jClEEjFVupUg9h26srtgordg/LBzPctqUKGmkauhEgAt78w4d9WMj
         bJgCU+m6WBRUYe/1L+Ji7PLZwiuju5wSUYwTvmfbdOHK1MKuhUO7v8Fo6dEGr5tTW7yx
         k7RyDlvKVsTIbs5zDZI0xN9pdiWe31v/E9NxdUdmOCINoxKmH2xgi+ly4Og6Hk8wRcZK
         Rm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtvGZ8n4FSUiZC1NqU5iF6hRUeBM3B9Hk15V/NQFoF0VJb+xHwtVmnIGKMR4aCPnSKrg70hbCDq91009fRhsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxafU4M2/e+dYksoMiiX1EJQm7cQtuGh1PtY01YCLObCGhqhEI2
	WT9fvlJgfJBVy9tL5Cq9iJyO4ujzcsZHxzpMlNov2odF4sDUKiEw2S8fxllQSXiwoOnSO9i70sW
	v3vArPZky3vjKqm0F/9qiRGVBsqPmKBgqGeD5dHFe6tXE68c=
X-Google-Smtp-Source: AGHT+IEMhDfqbG5brz/dGYPouOPPOUBo72Vc2UkiM0rMvcuEuDoxMoy9g+ucHEZKLIEUUYCSLq9aPbcxAUh/Kgl7GFc=
X-Received: by 2002:a05:6902:e0c:b0:e29:309c:26cc with SMTP id
 3f1490d57ef6-e2931dccb2fmr14871975276.43.1729176494833; Thu, 17 Oct 2024
 07:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410171420.1V00ICVG-lkp@intel.com>
In-Reply-To: <202410171420.1V00ICVG-lkp@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Oct 2024 10:48:04 -0400
Message-ID: <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>
Subject: Fwd: [linux-next:master 4380/4439] include/linux/fortify-string.h:293:17:
 error: call to '__write_overflow' declared with attribute error: detected
 write beyond size of object (1st parameter)
To: Yafang Shao <laoar.shao@gmail.com>, linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not sure why the kernel test robot only sent this to me, but this
looks to be a strscpy() issue rather than an audit specific issue.

---------- Forwarded message ---------
From: kernel test robot <lkp@intel.com>
Date: Thu, Oct 17, 2024 at 2:29=E2=80=AFAM
Subject: [linux-next:master 4380/4439]
include/linux/fortify-string.h:293:17: error: call to
'__write_overflow' declared with attribute error: detected write
beyond size of object (1st parameter)
To: Paul Moore <paul@paul-moore.com>
Cc: <oe-kbuild-all@lists.linux.dev>


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master
head:   15e7d45e786a62a211dd0098fee7c57f84f8c681
commit: dfdb07df2ab66ff4fd2f82039e871e7ab922dc81 [4380/4439] Merge
branch 'next' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
config: x86_64-randconfig-005-20241017
(https://download.01.org/0day-ci/archive/20241017/202410171420.1V00ICVG-lkp=
@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=3D1 build):
(https://download.01.org/0day-ci/archive/20241017/202410171420.1V00ICVG-lkp=
@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:390,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from kernel/auditsc.c:37:
   In function 'sized_strscpy',
       inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
>> include/linux/fortify-string.h:293:17: error: call to '__write_overflow'=
 declared with attribute error: detected write beyond size of object (1st p=
arameter)
     293 |                 __write_overflow();
         |                 ^~~~~~~~~~~~~~~~~~
   In function 'sized_strscpy',
       inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
>> include/linux/fortify-string.h:293:17: error: call to '__write_overflow'=
 declared with attribute error: detected write beyond size of object (1st p=
arameter)
     293 |                 __write_overflow();
         |                 ^~~~~~~~~~~~~~~~~~


vim +/__write_overflow +293 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  274
03699f271de1f4 Kees Cook      2022-09-02  275  /* Defined after
fortified strnlen() to reuse it. */
e6584c3964f2ff Kees Cook      2023-09-20  276  extern ssize_t
__real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
e6584c3964f2ff Kees Cook      2023-09-20  277  __FORTIFY_INLINE
ssize_t sized_strscpy(char * const POS p, const char * const POS q,
size_t size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  278  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  279   /* Use string size
rather than possible enclosing struct size. */
21a2c74b0a2a78 Kees Cook      2023-04-07  280   const size_t p_size =3D
__member_size(p);
21a2c74b0a2a78 Kees Cook      2023-04-07  281   const size_t q_size =3D
__member_size(q);
21a2c74b0a2a78 Kees Cook      2023-04-07  282   size_t len;
a28a6e860c6cf2 Francis Laniel 2021-02-25  283
a28a6e860c6cf2 Francis Laniel 2021-02-25  284   /* If we cannot get
size of p and q default to call strscpy. */
311fb40aa0569a Kees Cook      2022-09-02  285   if (p_size =3D=3D SIZE_MAX
&& q_size =3D=3D SIZE_MAX)
a28a6e860c6cf2 Francis Laniel 2021-02-25  286           return
__real_strscpy(p, q, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  287
a28a6e860c6cf2 Francis Laniel 2021-02-25  288   /*
a28a6e860c6cf2 Francis Laniel 2021-02-25  289    * If size can be
known at compile time and is greater than
a28a6e860c6cf2 Francis Laniel 2021-02-25  290    * p_size, generate a
compile time write overflow error.
a28a6e860c6cf2 Francis Laniel 2021-02-25  291    */
fa35198f39571b Kees Cook      2022-09-19  292   if
(__compiletime_lessthan(p_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25 @293           __write_overflow();
a28a6e860c6cf2 Francis Laniel 2021-02-25  294
62e1cbfc5d7953 Kees Cook      2022-10-02  295   /* Short-circuit for
compile-time known-safe lengths. */
62e1cbfc5d7953 Kees Cook      2022-10-02  296   if
(__compiletime_lessthan(p_size, SIZE_MAX)) {
62e1cbfc5d7953 Kees Cook      2022-10-02  297           len =3D
__compiletime_strlen(q);
62e1cbfc5d7953 Kees Cook      2022-10-02  298
62e1cbfc5d7953 Kees Cook      2022-10-02  299           if (len <
SIZE_MAX && __compiletime_lessthan(len, size)) {
62e1cbfc5d7953 Kees Cook      2022-10-02  300
__underlying_memcpy(p, q, len + 1);
62e1cbfc5d7953 Kees Cook      2022-10-02  301                   return len;
62e1cbfc5d7953 Kees Cook      2022-10-02  302           }
62e1cbfc5d7953 Kees Cook      2022-10-02  303   }
62e1cbfc5d7953 Kees Cook      2022-10-02  304
a28a6e860c6cf2 Francis Laniel 2021-02-25  305   /*
a28a6e860c6cf2 Francis Laniel 2021-02-25  306    * This call protects
from read overflow, because len will default to q
a28a6e860c6cf2 Francis Laniel 2021-02-25  307    * length if it
smaller than size.
a28a6e860c6cf2 Francis Laniel 2021-02-25  308    */
a28a6e860c6cf2 Francis Laniel 2021-02-25  309   len =3D strnlen(q, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  310   /*
a28a6e860c6cf2 Francis Laniel 2021-02-25  311    * If len equals size,
we will copy only size bytes which leads to
a28a6e860c6cf2 Francis Laniel 2021-02-25  312    * -E2BIG being returned.
a28a6e860c6cf2 Francis Laniel 2021-02-25  313    * Otherwise we will
copy len + 1 because of the final '\O'.
a28a6e860c6cf2 Francis Laniel 2021-02-25  314    */
a28a6e860c6cf2 Francis Laniel 2021-02-25  315   len =3D len =3D=3D size ?
size : len + 1;
a28a6e860c6cf2 Francis Laniel 2021-02-25  316
a28a6e860c6cf2 Francis Laniel 2021-02-25  317   /*
a28a6e860c6cf2 Francis Laniel 2021-02-25  318    * Generate a runtime
write overflow error if len is greater than
a28a6e860c6cf2 Francis Laniel 2021-02-25  319    * p_size.
a28a6e860c6cf2 Francis Laniel 2021-02-25  320    */
3d965b33e40d97 Kees Cook      2023-04-07  321   if (p_size < len)
3d965b33e40d97 Kees Cook      2023-04-07  322
fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, p_size, len,
-E2BIG);
a28a6e860c6cf2 Francis Laniel 2021-02-25  323
a28a6e860c6cf2 Francis Laniel 2021-02-25  324   /*
a28a6e860c6cf2 Francis Laniel 2021-02-25  325    * We can now safely
call vanilla strscpy because we are protected from:
a28a6e860c6cf2 Francis Laniel 2021-02-25  326    * 1. Read overflow
thanks to call to strnlen().
a28a6e860c6cf2 Francis Laniel 2021-02-25  327    * 2. Write overflow
thanks to above ifs.
a28a6e860c6cf2 Francis Laniel 2021-02-25  328    */
a28a6e860c6cf2 Francis Laniel 2021-02-25  329   return
__real_strscpy(p, q, len);
a28a6e860c6cf2 Francis Laniel 2021-02-25  330  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  331

:::::: The code at line 293 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move
fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--=20
paul-moore.com

Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582621CCB47;
	Thu, 31 Oct 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407260; cv=none; b=qoC8oE/I/BrJ8FLhtM990Sw6VDdmEJYgZWCb/Zl7+BiSZdz6zulDQFpPULIj8ZblMTofkK6q+N6b4RsHFBo+o7UAdrfKJViqz4MgKogvET8oDKSVNljVIK6cKmOUKsHlVDPhsWZoaSmwPksTnfO/6JkfHiE7OD0SaG4UeadlZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407260; c=relaxed/simple;
	bh=WFBhdNjX7kERBwmTs2C9Ud/0Kv4rSTvjgYUcrlUpH80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QMdcBgN35iENxZBNVeMgd/yI7Yg4Z46rbNguwHAcLK3mETXx45qGnyIT5ZWsiqKZWhgPyt/EpCfH4Rnz1fD/DoFhFk9enGQRtBb8OmZoKGBIPjyggP5hBZnZWPyTvFARkyyeUMCJIymRoFIHSH7GW3es3GiJ0QRH5ttJ4vDinKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Vbst9wd2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Vbst9wd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730407246;
	bh=WFBhdNjX7kERBwmTs2C9Ud/0Kv4rSTvjgYUcrlUpH80=;
	h=Date:From:To:Cc:Subject:From;
	b=Vbst9wd2ipoblYO677Z5B9j73IhEV0gbf4JpA2d9VfQfk/+sTHL2AVrZ7MN9CXJ7z
	 lI1Y9B4/FN1FYHupcAJ7tYRn8im4DiTsdygJUjMLVcQOeKcqg/ZwZtIUVzYJup11ez
	 gCTHLRnTtfQ1HaAzr1Nf2CG22Yes0OjiNGdnZaXM=
Date: Thu, 31 Oct 2024 20:40:33 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fortify compilation warning in __padata_set_cpumask()
Message-ID: <db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Kees,

I'm running into compilation warnings/errors due to fortify-string.h.

Environment:
- Commit 0fc810ae3ae110f9e2fcccce80fc8c8d62f97907 (current mainline master)
- gcc (GCC) 14.2.1 20240910
- Relevant config (from an Arch Linux distro config):
	CONFIG_64BIT=y
	CONFIG_X86_64=y
	CONFIG_NR_CPUS=320
        CONFIG_NR_CPUS_RANGE_BEGIN=2
        CONFIG_NR_CPUS_RANGE_END=512
        CONFIG_NR_CPUS_RANGE_DEFAULT=64
	CONFIG_PADATA=y

Warning:

      CC      kernel/padata.o
    In file included from ./include/linux/string.h:390,
                     from ./include/linux/bitmap.h:13,
                     from ./include/linux/cpumask.h:12,
                     from ./arch/x86/include/asm/paravirt.h:21,
                     from ./arch/x86/include/asm/irqflags.h:80,
                     from ./include/linux/irqflags.h:18,
                     from ./include/linux/spinlock.h:59,
                     from ./include/linux/swait.h:7,
                     from ./include/linux/completion.h:12,
                     from kernel/padata.c:14:
    In function ‘bitmap_copy’,
        inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
        inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
    ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 41 and 536870904 bytes from a region of size 40 [-Werror=stringop-overread]
      114 | #define __underlying_memcpy     __builtin_memcpy
          |                                 ^
    ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
      633 |         __underlying_##op(p, q, __fortify_size);                        \
          |         ^~~~~~~~~~~~~
    ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
      678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
          |                          ^~~~~~~~~~~~~~~~~~~~
    ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
      259 |                 memcpy(dst, src, len);
          |                 ^~~~~~
    kernel/padata.c: In function ‘__padata_set_cpumasks’:
    kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 40]
      713 |                                  cpumask_var_t pcpumask,
          |                                  ~~~~~~~~~~~~~~^~~~~~~~
    In function ‘bitmap_copy’,
        inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
        inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
    ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 41 and 536870904 bytes from a region of size 40 [-Werror=stringop-overread]
      114 | #define __underlying_memcpy     __builtin_memcpy
          |                                 ^
    ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
      633 |         __underlying_##op(p, q, __fortify_size);                        \
          |         ^~~~~~~~~~~~~
    ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
      678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
          |                          ^~~~~~~~~~~~~~~~~~~~
    ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
      259 |                 memcpy(dst, src, len);
          |                 ^~~~~~
    kernel/padata.c: In function ‘__padata_set_cpumasks’:
    kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 40]
      713 |                                  cpumask_var_t pcpumask,
          |                                  ~~~~~~~~~~~~~~^~~~~~~~
    cc1: all warnings being treated as errors

Code:

   712	static int __padata_set_cpumasks(struct padata_instance *pinst,
   713					 cpumask_var_t pcpumask,
   714					 cpumask_var_t cbcpumask)
   715	{
   716		int valid;
   717		int err;
   718	
   719		valid = padata_validate_cpumask(pinst, pcpumask);
   720		if (!valid) {
   721			__padata_stop(pinst);
   722			goto out_replace;
   723		}
   724	
   725		valid = padata_validate_cpumask(pinst, cbcpumask);
   726		if (!valid)
   727			__padata_stop(pinst);
   728	
   729	out_replace:
   730		cpumask_copy(pinst->cpumask.pcpu, pcpumask);
   731		cpumask_copy(pinst->cpumask.cbcpu, cbcpumask);
   732	
   733		err = padata_setup_cpumasks(pinst) ?: padata_replace(pinst);
   734	
   735		if (valid)
   736			__padata_start(pinst);
   737	
   738		return err;
   739	}


The weird thing is, that only the cpumask_copy() in line 730 triggers
this warning. The one in line 731 doesn't. Also this is the only
instance of the warning I see in the whole build.

The warning goes away with the following change, but that introduces
runtime overhead and feels wrong. Also it doesn't explain why this
specific call is different from all others.

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 9278a50d514f..ded9d1bcef03 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -836,7 +838,7 @@ void cpumask_shift_left(struct cpumask *dstp, const struct cpumask *srcp, int n)
 static __always_inline
 void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
 {
-	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), large_cpumask_bits);
+	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), MIN(NR_CPUS, large_cpumask_bits));
 }
 
 /**

Any ideas?


Thomas

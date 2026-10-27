Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138957;
	b=Fas+fBk5836S9mfmZooSckH95QSiQli3QMY9J+JTVpkYkMduD6mekGsdSaN8xhLFdaWl
	 wVAAkWX7xalJCkZQuaRiP0X6cs6RDiQEnDuc3cWAbsi2fJhDhTo9XkPcf5EKxlfuxwTwt
	 N4X8ki/Iv8Y6fLRwnQK5gq3Z3mvsDZVptezAXWsVkkOrcBnMW5U9keX929eBYk0Filx1v
	 Jw+3fRUVXGlyWcrLJU2WnK/uM6iv2gzPZbgnn1V7JKgOfIoEH3W0U9fowy2y3cDXp6nY/
	 Q3WQ55bBcQ9ZDfOc6AoFaL4wU3f10kv8DXzBpaad0TPtxzRjokFNmrNkv6u+wuUhP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rBwkpeXs9IYTeLqZKiGyRddb6tb6kIGdVCVxCuWmkaQ=;
	b=wTUxEVoJonK29zV/D5XX0Abqlz2S2OLmJoRQqww0Hsk9OfgM+rhOrBwk62IgsEEHzctS
	 5QpW8HVKWtwhtLTOlr4Z9JpTIuH44ZuiKo1oWDbMsRBWoGnRapLcgaiweMqLJf9ng+Opv
	 oNgocw48/jWpXdSlirRCVvSAzyERYls9JCnqvtGQ+bm0/6Zlqc9zBCD2qTIokcPyQzJrx
	 o5SkGDlXcgiacI+9w0s079eLhvQCS6Ee/95PHN49qSbS9nicN0+YYf+F+10kZjYiX7p/2
	 ZwJoHx1eokGwOVzz3xWm1XFiEwkxH/8XHnZ+xK9mKxo1+HvOcYs7LjaNDbxepGw0Big==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qrqnZ0y6;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AB606A31A
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 22:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qrqnZ0y6
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so3283305e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138955; x=1793743755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rBwkpeXs9IYTeLqZKiGyRddb6tb6kIGdVCVxCuWmkaQ=;
        b=qrqnZ0y6YZ/9dGk5YnV6G2G4cuHt3qa5epDxGEeShFv/mwOZJh4aOm54jjfhK0cKDC
         w7WCz/UjL9XZ/aI/QvmhqRNnx07nQ8dwoV0QC2gOJ+vilg+v7Y+BeXT2uJC2OXmSLPhM
         MQZX0xZo63tTsvnHpQeFFMNgBbw1aRStexziSiX2W838LaSPkEihUaVdl8iAB/KMPXq8
         46SJ41HrwUr7dimNCHQ9mOcdMe8/QTCCbVhoevsZ3w60Jf3LsLaIGjRn5lGHkVrl87UV
         m5WTA0wfEJqw1SceMezQa68mcifLLXgLxywcmRWudfr5sN9Qt4CHdRI0VpSVKxuTYWPr
         rMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138955; x=1793743755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBwkpeXs9IYTeLqZKiGyRddb6tb6kIGdVCVxCuWmkaQ=;
        b=rXjgZsgDzpLCdDyefPQsuPUymWoKsBAk5nRoyi7ifknHkFPmkNhgi36sLc86igw8LT
         9SkVrI9NN6GK6AAwBgapRnrQ672pXLotXZ/Ux2W4IRrFc20NnRbFYHnJmCTVA9TGeN3h
         Bk0KQJJPMm8I9g6MuOhEFwTQIe78xQVoYYC95EACoYrggEvuPwqLAbeEzOSyQWpr01yy
         WZBb3HjiroIqMy5LySunKjPJ4e9pSkeNt0QmDVi2ickhkZUxJxHt3nGtVBsyIWBO4D+R
         yp+zaIcyJPqmqomUtKFwAQRV4Vci6yCzDgL/vqwmfPalvgiwKtZFHuVgBC3W5WvuKDra
         0zjA==
X-Forwarded-Encrypted: i=1; AKwUvBxfdHRv7R+Wjwno3rbFXhg4W8Il+QH6Lm5VSm1dF+i4ZbRLZLUPVN33/qovMnJMS16W4h5yfTc7osWZ1c8w45U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnEUVDg2pDqab6l24Yi/IbeuQNBKhil9V12AJ/oQGUzJXPjPME
	ZNISD77qkz90vCT/RA3wfhgsdXoxTgsC1OZblBGCKVdWptClo9E338gs
X-Gm-Gg: AYBFou3e1JGh/m/lvp/Hm0RUnvE7ETxybwlYc6Awk/KXK0atbTjpZrqJJpOAiYBNSx6
	kUU3WxS0inGVFlOV37W2ahqDQLlMQwd4nGuJMpWXYAhDolLKLDqc9WEQD0pLovsAvJRDUy7HQvB
	spXAt09+jw5gTGlMlalPnkHvwhPgjioG+IOJl7CC3qB3rnled+R6hO5hRb/Dqu4FL3jYtXcWwbT
	W5nLdrpvP0LwY78RQwmNPwBNK4dWd5eeP//E77AUxNNSeSAsgrk7pb1D27UYyDe0AZBhGdLEU06
	mORN6YtzxZG5lOYLmyNfB4Ee5552FOuVVv70TArLoGZ2J7PoEHubz9qnkANicXW0f0C2/7zuvej
	BTX/AWqBe6t9bfRBv79UzXMml/Q0vWDS9Sh4Zu8MOLv+2PCYMnUEO2LVGdAPtTQn5ejZ5a1uNn7
	eA01bPJey3hjh0tdvZ4QetleRuD6p6geXe6kbxEgmW3zDd71tghwx3WpVFjMJgFBdb/vyRiOPwP
	jR1/a1EfqqB5jjDRj+4zndkR5cNVCWf4It5FIPYbqtwLj6YfwHmmTubAg==
X-Received: by 2002:a05:600c:37cc:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a968552939mr5068125e9.34.1793138955534;
        Tue, 27 Oct 2026 15:09:15 -0700 (PDT)
Received: from thinkpad ([2a00:1370:81ac:50e7:d3c8:c903:5898:874a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9792269b2sm1720035e9.13.2026.10.27.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:09:13 -0700 (PDT)
From: Andrey Zakharov <dedemorow@gmail.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	hpa@zytor.com,
	Andy Lutomirski <luto@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Zakharov <dedemorow@gmail.com>
Subject: [RFC] x86/ioperm: boot-time switch to disable iopl()/ioperm()?
Date: Wed, 28 Oct 2026 01:09:04 +0300
Message-ID: <20261027220904.15896-1-dedemorow@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

KSPP issue #97 (https://github.com/KSPP/linux/issues/97) asks for a way
to disable iopl() and ioperm() at boot time, so that a distro can keep
CONFIG_X86_IOPL_IOPERM enabled while system owners can still turn the
syscalls off.

I read Thomas's recent explanation in the "iopl - change I/O privilege
level" man page thread, and Andy's reply that iopl() is low maintenance.
So before writing any code I would like to ask whether such a knob is
wanted at all, or whether CONFIG_X86_IOPL_IOPERM=n and lockdown are
considered enough.

As far as I can tell, the options today are the build-time
CONFIG_X86_IOPL_IOPERM and lockdown=integrity, which also restricts
/dev/mem, kexec and other features. I did not find a boot parameter for
this in next-20261022, nor a previous series on lore (I searched for
iopl and ioperm).

If it is wanted, the change would be small:

 - an early parameter, modelled on ia32_emulation= (kstrtobool() in an
   early_param handler), that sets an __ro_after_init flag;
 - a check of that flag in ksys_ioperm() and SYSCALL_DEFINE1(iopl) in
   arch/x86/kernel/ioport.c, next to the existing capable(CAP_SYS_RAWIO)
   / security_locked_down(LOCKDOWN_IOPORT) checks, which today already
   reject only requests to gain port access;
 - an entry in Documentation/admin-guide/kernel-parameters.txt;
 - default behaviour unchanged.

Questions:

1. Is a boot parameter wanted, given lockdown and the compile-time
   option?
2. Thomas mentioned that the permission bitmap can also be changed
   through x86-specific VT ioctls. Should such a knob cover those as
   well, or would it be incomplete without them? I have not looked at
   that code yet.
3. Which error should be returned when access is refused this way:
   -EPERM, as for lockdown, or -ENOSYS, as when CONFIG_X86_IOPL_IOPERM
   is disabled?

No patch yet. I will send one only if there is interest, and I am fine
with "not needed" as an answer.

Thanks,
Andrey Zakharov

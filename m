Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78728153BCE
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622334; cv=none; b=FdH6JnsLgBh9FuzSOBE33H+4y/SZ9pHQV0UPaE2J4oo38l6GWY1D7SIxY1krEqHZMqOmVEeENqq4zl15i6i3QnGGPGdi6/nZMis+a3QkJQuOm60cdIGiPQK9CJuFR6aEn6Pi3hAtKuTCopfMBz9VCEP3RUtuw5Yg2Y8XP2+2dDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622334; c=relaxed/simple;
	bh=ZgiBlspHc07RmIjkE8DOJutQscrRDMa0qQqnkJLfA14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hPJPviB9XOusAqXrAkB0hXJnkKzmNvViurVhHv/0UdrC9DTdrwlCIj+JMM0mh6yk/PLhl+NzHgafFCgtPyrhMlbmwGuy0YeXMTG0yirYezeDvHzPERj4jY1R9DCMOomrx7jLCfovm6xGcU4SXYi8jXAsOmB6v2HKzu4Mmy+zlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U/4cQIsy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/4cQIsy"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso4936502a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708622332; x=1709227132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVmjmBRsPoGn9M0d14QLHctUVl0w4akGVbG8WJOk1IA=;
        b=U/4cQIsynNWm0yE8aI8yUDDxeWNQ/HlyVabA58sdqovYKKw2V2QcyGN6C/Ulyeu1X6
         FoM7Fx0R5A0qdWLivkKDDuhubu6+kWkjBs71pl2hh990taLhTzq/xGcVXMmapSZZuNmK
         3++BZmBpr1on0Y0kBJE4X1IxQMCtdECuWDFnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622332; x=1709227132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVmjmBRsPoGn9M0d14QLHctUVl0w4akGVbG8WJOk1IA=;
        b=QKg6qaiFM6EsuBoEwKaDcskrOtXRypznZbu5IcEeZ2n8YrflTYBCbX4fDK7p249Yk0
         oIcVQ8dkrFiFtCASGSO81S2JUtFQ0PdLAk15oljjIoCMOM+atq5/M5U3MXsLCnfOuJ7G
         x22hwcBXDLaVFkmsHwdsBq7KER5yle/LvnYGXmKOE0d36ztAWVsutRgFvm6jrBRPtET3
         H+AhltO2bEvccRDSK1vbdjGSf+WuLnqGmxk2uteAm2BqgQZG5GvrUv5Bv3X8i1X66Exs
         CZBq77/VJwWjZolNgPHh/WnjZC189tWPkzvhOt+EslYQjxn5M35bm6gLUmhQ9dnzFewP
         UFWw==
X-Forwarded-Encrypted: i=1; AJvYcCXruJE9jN6l8ZbV4F+Z7V6yaHs6WNVHyLF94BlMwnGgSAz5pofW9zZHXHykybRKfHBLVJSVDEI2qukoawppDmks2I1R6ioDxgk6zzr8OOg8
X-Gm-Message-State: AOJu0YxU21E1+ek0pyIqiViTwn1u33SZKsvtN2nsq4/jFd98XZ8IzLrX
	Hk3Xk1/riJZeKtpv/dxSwatxFDdE16kPUH56T74WGG4AGSydPQ4U6QgGRzNSwA==
X-Google-Smtp-Source: AGHT+IHEgOOrFNITHcUyIpVZpjASQNJ0KWkdYx+1YAJkzhl3M0qVg0o0+Za1mYOSj5acpB1pE90N/A==
X-Received: by 2002:a17:90a:d501:b0:29a:496a:ccb3 with SMTP id t1-20020a17090ad50100b0029a496accb3mr1842380pju.24.1708622331654;
        Thu, 22 Feb 2024 09:18:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ss4-20020a17090b2ec400b0029930881068sm4322632pjb.49.2024.02.22.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:18:51 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Kristen Carlson Accardi <kristen@linux.intel.com>,
	=?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jeremy Fitzhardinge <jeremy@xensource.com>,
	Roland McGrath <roland@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86, relocs: Ignore relocations in .notes section
Date: Thu, 22 Feb 2024 09:18:47 -0800
Message-Id: <20240222171840.work.027-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZgiBlspHc07RmIjkE8DOJutQscrRDMa0qQqnkJLfA14=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl14H3cLKBllAwCTNaA+sMR/e+lwUx3DC6qFCVS
 WLfUp2WGuGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdeB9wAKCRCJcvTf3G3A
 Jjr9D/9AiSu2IAmMp7CrzXigYeYkg+Ret+8/WgaWkZRxGZ9IzL9HbrkxFmsSSWFpFbA2+CwZ/ua
 N683lCDixXYyFYsVv93ierIErJDlwmbzlyE6HvkSC75T3C2lETqleWI6b6T+JMfXMt0U9h7Loyb
 9Llx7XcUEHUZWiXbUJVomSX6kKrix9wQJE50f6un4yRz/MRjqqvQiLDNcI6MyhsmBJMV5Pl73bz
 qmqiysNJteCc1MMcSOGTwh9JGwCiyJZ9ryqgbOVNT3meWNsue3Oe+bcdl4WqgOjci63q5BlQb5P
 9bGKIL6ky9Dvz+bxGMvAgaOgdKtdKdxKrr/mqvaR7MOHQBDkhNnOpp7l4BABQPDyEaYPztuGU9T
 8pa5gQnNQXVctOyLy0LaSoMWmGnRpaosfkThIQmJfPUFK7obKhWDp6zrHaUPmHe4xHxAgtK/Q2x
 xjpkQ5J9XrYy/dxzAfTn1cZwGKcZiTe/Mxuw29A39MQFc76JboCCwZaIJrMnv5oaRUmcuHEYbDp
 j6oqK0b0UecdkKp3rDRLf5C7DoA9P+Cx2kiyzxJxw2Hr2xJYgGfwAKTdsabyW8q8YsFDbzAcUld
 vo+1xeyWiqTE/DBBgn7dYptvxftQ5QYJn65T+X6ppNfkpKfuAf/avEjZFHa9lMDpewpgyt3qKK3
 h4qLM8o P1monr5Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When building with CONFIG_XEN_PV=y, .text symbols are emitted into the
.notes section so that Xen can find the "startup_xen" entry point. This
information is used prior to booting the kernel, so relocations are not
useful. In fact, performing relocations against the .notes section means
that the KASLR base is exposed since /sys/kernel/notes is world-readable.

To avoid leaking the KASLR base without breaking unprivileged tools that
are expecting to read /sys/kernel/notes, skip performing relocations in
the .notes section. The values readable in .notes are then identical to
those found in System.map.

Reported-by: Guixiong Wei <guixiongwei@gmail.com>
Closes: https://lore.kernel.org/all/20240218073501.54555-1-guixiongwei@gmail.com/
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: "Jürgen Groß" <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Jann Horn <jannh@google.com>
---
 arch/x86/tools/relocs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index a3bae2b24626..0811fff23b9c 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -733,6 +733,16 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (sec->shdr.sh_type != SHT_REL_TYPE) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (strcmp(sec_name(sec->shdr.sh_info), ".notes") == 0) {
+			continue;
+		}
+
 		sec_symtab  = sec->link;
 		sec_applies = &secs[sec->shdr.sh_info];
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
-- 
2.34.1


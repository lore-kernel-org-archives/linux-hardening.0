Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A14EB45
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056681; cv=none; b=BpFysub9YgWIlIu1pVcEUB6hKVyjBZcht/fQLSrxUh2BLIrNLJQtHes4Kgi4d/kLHriV3pcPgNo9aFNzapocuTsSUdqGKF63lxAgOGmgi8L20+vz/Jy/jJCqtGT3346tyri/eLlQ+XdRBBwKqllbj5y/yam3N9BGWlUWdsrhAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056681; c=relaxed/simple;
	bh=+0OPAWAs3sfMdgF2nC2ThcDNMyrAtbB6XPH0ctrI4rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ceSOpAPzERbxm275MJaliRj6iyI8RyKHZ7q7YPVPKCH2Vc13C3XhJBPl4nu/ClZHScWyZz2A8u9is3YEkd6a6tYZYPRENZjoBb8rARSEXUrYvDgl2r0ulrGutqZQMNzuFPNggK85HJXbwDuZIpOX6W0TXz6HJ5Ea4dSFzmSniDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iI0HGOXU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iI0HGOXU"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3158126a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 09:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709056679; x=1709661479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kC2wEvtOaFP3h4cQZlxM1jPUFNWCk373B+A/I3NBDq4=;
        b=iI0HGOXU2IUzl9PCOIWsRp89rrH1tp5b9Ud7dp2+6OsbmRSAzfdEeTwj99+qjl37w5
         VTnggMVM2q0obOBFcJDtNcK8q/Fsrah3G+nNT6KmbNf0i3PislmCdqEr7DsHHhgCLzth
         9F6G/t8UO4MqlrrWH/V6dpaGr2NFDXaQXp9+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056679; x=1709661479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kC2wEvtOaFP3h4cQZlxM1jPUFNWCk373B+A/I3NBDq4=;
        b=MLJWigg7m6ytiNwEGojBO2W3SoJI8mnyXTMJZM3Kyt8d8wZmIcAY1ZNrnxTpVTKkB2
         ATsNMNwC3dpdbHxV5mr2GszsVLiqgYKLJxsrbYfkp5i7TjmqwiIroMn0kjMdjG9Fm+Vt
         5skCEapm/VLN8YrQ8b2MAwychlG4ZlSpenFvHNk68YC+OZhAeFR9ZlcwcDBvKFJLBrUK
         xqiZVTHxsviHeaPJiJF5ob4e/xeJC1+JZsQQZn91sTjP/peHF58IVU332iezL09twoA9
         3FL2aacQgdp+o8MW8EmV5oEDA69WF0R77XUbKqlFSMPAzdoaDm9u8dK3mOFdbjXarH8q
         33IA==
X-Forwarded-Encrypted: i=1; AJvYcCUNJAObVNgEYPd+7ICjaHzmJTgFKNRBzTLQLEcij6iQ5n3oZd9P+G3z5hClhrwuUdTS32YsD6eXjBnxUpt2EwpiVCFzI4IxeQcVV6fw7pnQ
X-Gm-Message-State: AOJu0YzwtEqj1CdrJHOPXCHTX2ThyVrmBd6fhSBciAPa1KL5reBHBILq
	Q4kLEgqWj/N7pJlGrinUw2jXha+v+GdYkyB3th4XKTFvdP6w7GhaUbf3gBpqoQ==
X-Google-Smtp-Source: AGHT+IHUUUP9/UmmHrjaYXTI+M7Y37qSM1X5UbcLLZGe58gX4f0lCcIEDgjF5IXEEtRaPtrm8FmQpg==
X-Received: by 2002:a17:903:1111:b0:1dc:139:8488 with SMTP id n17-20020a170903111100b001dc01398488mr10689811plh.5.1709056679376;
        Tue, 27 Feb 2024 09:57:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001dcc138d4afsm977717pll.34.2024.02.27.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:57:58 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Kristen Carlson Accardi <kristen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jeremy Fitzhardinge <jeremy@xensource.com>,
	Chris Wright <chrisw@sous-sol.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] x86, relocs: Ignore relocations in .notes section
Date: Tue, 27 Feb 2024 09:57:54 -0800
Message-Id: <20240227175746.it.649-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252; i=keescook@chromium.org;
 h=from:subject:message-id; bh=+0OPAWAs3sfMdgF2nC2ThcDNMyrAtbB6XPH0ctrI4rY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl3iKiWcoAm/pK9IhJJhi0v/ve2Z+RTlBNhV4/B
 7Jqo6TYkDqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZd4iogAKCRCJcvTf3G3A
 JgcrEACDAm+AhGqv9vV78y0ouPqZt08aHzKCsCeWI6lwhfwGgZe8ijuaongDeSFNCgnZ18wqT/E
 Hh+z5QHgRKGysxtXWrTlNMPKTc0wUGMaRLOYF/M17JOawinba/Diinu5X9VHxZN60b+3hyNCmg7
 2GAsfefI+xOZUgdvpb/37o+UmF+B7IrR3RrOvMRWh5er9F+dQVKunxeaEjjwYqnCSRNNwf+PS6E
 MXguEh49RMJjJ8C+2djWZg5x8eXSZXZldVsNHWqf216b0Hy1jFrTXru6ZJKztcxA8royqgN51YQ
 bZjyr3I1yqM8WhfCIZ6czF2pNRwCBuyw/2zw4K2rCVgWeqqAxlKpgrXttfYzkihUWjql3iI8D5g
 rnTZNwlpiq9UqP79/c6WJut4Ms746KGUpOeRh/8tarJ/m9XFXAsrAt6sSW9zPQzpsMeHRK/B1S2
 UW55C8CLV5YcXV8D5271zrHoqlO7TBuaeqbEwkJNLkot9HZSGpzFnNZJs9CljTut5phGq6JLV29
 FSJtFUmIwdj1hCu0+FjeDVlsgLqE/FwI1X94pFfNhyExNpqcpwdGm0vuy77wwYZCjaNzplrk/FY
 HAdgO3sH/FJ+bLOo1DwDPotHjYNDLJPfkRD62xD9vkhzVhyE3nf7HRBeWBGRDqs7oBENd45BHLS
 rWx8L8J AtZrqrQg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When building with CONFIG_XEN_PV=y, .text symbols are emitted into
the .notes section so that Xen can find the "startup_xen" entry point.
This information is used prior to booting the kernel, so relocations
are not useful. In fact, performing relocations against the .notes
section means that the KASLR base is exposed since /sys/kernel/notes
is world-readable.

To avoid leaking the KASLR base without breaking unprivileged tools that
are expecting to read /sys/kernel/notes, skip performing relocations in
the .notes section. The values readable in .notes are then identical to
those found in System.map.

Reported-by: Guixiong Wei <guixiongwei@gmail.com>
Closes: https://lore.kernel.org/all/20240218073501.54555-1-guixiongwei@gmail.com/
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
 v2: switch to a SHT_NOTE check (jgross)
 v1: https://lore.kernel.org/all/20240222171840.work.027-kees@kernel.org/
---
 arch/x86/tools/relocs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index a3bae2b24626..b029fb81ebee 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -653,6 +653,14 @@ static void print_absolute_relocs(void)
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+			continue;
+		}
 		sh_symtab  = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
-- 
2.34.1


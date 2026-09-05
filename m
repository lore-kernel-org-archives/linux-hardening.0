Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A83BB9EF
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636612; cv=none; b=i+c3dEDfBXDuZopwu+y9O3uUbSYCQE6qm4ER7aPWFncfDcxp0HCDsCX+mtZ0eXB9tIseMkHPKox7eKiQMvrhIRRyVraje7DChZ2cK6Ai/n7KTAqfzV+xHmu7Z01wLfSDX+4MyFHL+plhA5KJXBxNdLTM/khJz+h2WSU0K6eK1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636612; c=relaxed/simple;
	bh=JPhW0tJqXaIn8Oiipq0xwNjIp3QnpGEFXpZHEWqLlVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTbvRphrJl7xfTORSMoz2gvT7QGIDqtmn35GNfN3XXvtFjLV+W1IUtlxsjI5QT5Cdnghpz4ccavRH/w4OFd49s9Sa+ggJk8i7CJdqc/YzGC80jFpeMaltNEvmM5nRxVhCiBobWrn+edhr+pIueqlivW7IbF37RXmlLrAZi88NHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENJa8j04; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENJa8j04"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-861a2ae9c51so26783457b3.0
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636610; x=1789241410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HR+LhYK6Oy70AMhIlonjkFs7HP8Yt8BezTGlAJPcneQ=;
        b=ENJa8j04hN7geklOBo0Q3UWejP7zqZ/L1I9sfqHzgE2MqbM6Fel9FuyJ9Euq6Rwu0D
         4qaWcsZgkCBiopu8TMknH8ktVA5AxwzOnMkV0k2L3WxtSKCEetXCk7PlIb4gPTiVIxmz
         Ievhv2bf8ccYaP1uLkDABcFn+9RZyMg3JEOy02eQjXVX5uiHYQ+5o1RwNEVHElDpIUNy
         6Vs/B1f0SwyGZW6/6PuvJ/aYr/qexjj677woZD3LGL06X8OSnx1znjItOTSO0toDFqvx
         f/p5IbPGiMqReOJO0MpC+1+uX7aqn3yiCyhre4hC75B2m2f5lQVJ/AyPcaUJUHnqwZ8f
         gvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636610; x=1789241410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HR+LhYK6Oy70AMhIlonjkFs7HP8Yt8BezTGlAJPcneQ=;
        b=hBETv11tkZwDmYZL/Sc8vKOA/UuQrgpNGHBq18hAUQJ2Dq0gkzvOxqqTIvQP4KvuJL
         uCfYCmzJMiL6yFQxXVEcoVjNBHWjA6DBrpJaENIxre/dAl2ReCsqCdZLpGkEpnnxbjE0
         DNptjQFRc183rx0+ynleWmiBScpELLnm6ID0BenN4lWYibG5nV0mbgErwQlpcucHG1fe
         mG+C6U5tA5pc4i8KnjPz9nHK3ZIxDQ8Lm9OsMNFHm+Ln+lbyEcG/kZ/FRZxzufyjhRON
         pJxi2cVMZrZ/2DAV0tPN8mCvEy/mCSP9bLLvk5975lE0DfLrq/x1wT0ogyquwaFf19CX
         FlYw==
X-Forwarded-Encrypted: i=1; AKwUvBxmkwPUahwZ03Tc0O3OpG3qoDS6WQp9i6t/Hqssp06lE8pXfFnVJ4nRaOV3m9NTp7CtHMcinUmRvtQKOiiN9Fw=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ9UxB1NFe3K4PFhjwhHxoJfAVbkLNY/GlCMyVJab39u7U7ycw
	H4lcfKxeylCzSEIf+lkaZ1zPP/qjpUNiRO/RV7N+lY2ZzX00KY2hQniV
X-Gm-Gg: AYBFou1Xb9pSBJZ/PLEplwdhfvfKjL/VMzVqtGIVcWujudj+JI+2jXxoHwastxDpmYW
	HKCjKCTxS7IUFqrSmkEsxker5o5snaZXgD9X6NizwEceIhc5zrEi37R6d0+UXdgITE5VVpfKeXw
	qDPMeLkoi1W4oD87VvgUyOdifLOlTM8mtvxBIJbj7CFgVlywnTTtyGGibQRZZO2lJ6Sh/Zypi+z
	NfCzLlRx+V8uNdeMTB/MSo2JaFp9m5lERqrndFEjcNVNzwvGvMVe/Wo4Qf4mit+2x4oNJDv9jfh
	LROu3ZBG+0iboDuw/JCiP8mhGGRFmn2Ko9dGoPJ2R2bGYZna3Hp9T35xnDtX4SNCvYe1RLU691C
	xLMJ/wHGLVhLkk3389kRMGUQgTpuI6hHM4Vxsc+rihoCrrCbZAeSgHzVGYtXAJX9xIrzgtb9CMu
	HvRCrGaWe0oQ9shDjNUxJlSU/qsQaKVUoTq3YiEpL713K1E7aTn6OvMNz3OyngLtp8+km4qm4=
X-Received: by 2002:a05:690e:241a:b0:66f:ae72:ddb2 with SMTP id 956f58d0204a3-66fb595067fmr3474531d50.16.1788636609633;
        Sat, 05 Sep 2026 12:30:09 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm5048420d50.9.2026.09.05.12.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:30:08 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:41 -0400
Subject: [PATCH v2 20/22] alpha: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-20-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=JPhW0tJqXaIn8Oiipq0xwNjIp3QnpGEFXpZHEWqLlVM=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E7ZFlC5udjK8G2+QNjblXbq+8wCGNa9X8Aisdcjd
 lKGzmeGjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmUxkjw8Y7bG+ji6
 30DMQV2kxNXgs9dNDgmlBboxzn5FQe0F5Ux/C/XsHX9Ad36NL+hrZzSm83227X+yEntV9rnaGak
 HO3Py8bAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

activate_mm() on Alpha calls __load_new_mm_context() which assigns a
new ASID and invokes PALcode swpctx. On SMP, an interrupt arriving
between the ASID update and the page table switch could see
inconsistent state. Ensure activate_mm() is called with interrupts
disabled during exec.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 33b51bef5139..e5611766b6d6 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -39,6 +39,7 @@ config ALPHA
 	select GENERIC_PCI_IOMAP
 	select AUTO_IRQ_AFFINITY if SMP
 	select GENERIC_IRQ_SHOW
+	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG

-- 
2.54.0


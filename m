Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00483396591
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636589; cv=none; b=MG4rUG9zHWbQFTbLBi8Cyqou1GIoH+Tj+x5ddKp8FG1yHfFtLQE16ATg+7f5pXLTo5Iml53bSl+ANcQInN0W4Kmg1G1J5i8lirmMvk8groz29g0j+Qushy7dyk/dkpODCOnGz874cr7j9AuJADKWGVJi9L4Y/4pyFRNTqff9StU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636589; c=relaxed/simple;
	bh=d64vrkzV8SwOJMlfAMFEdEJjMT39PCBSfivQv0NFu/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2UXoEiFGkNoi2YVI9wXkXbKBvW9KyaCEHy/+ZzqGiPuMvXyM4qPQnf5rjcg25ZAX4jD+R3ywwGAhwcqxyKucM2PIuW9FKrFVOwMDUBpS4SBkIxeMBKh7Xx2ohFbkF2+RD80fHalcm6+WKywV66FThuSBCOqYT5mVKWoDuhuMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAxC8DJ1; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAxC8DJ1"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86cba60d4f2so18663587b3.1
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636580; x=1789241380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6JdpH8z6Rb7sleDgNsPa+IW/WQmX2mRqnvOWICUv+Ss=;
        b=qAxC8DJ1oJZprWRGoKUSueX/DlAhcE+NuMXLAsk9BHdRXX8yaVbHQ3MzyRiBMmSimv
         PkyBxif8MLuX1LP0skZhoucKFX50HDgDZ+S5WkwCoduBxtQHwW0E7ptlG9W/HP5LOH9M
         5yVeLlE7V8TcPFAj+kbpJDXTfAjWSC/5GDpXO5kIVf6dAxBzOackN3UfgCfINaTTXe/s
         Gx+juww3HXV5O+jrJLrRpTZ3t125Q3kCnohUHCnRocgel+CcABF7lMb6IEvRK3MTjlyc
         TIBrzYoY/j/jR9vHiAKtN3SMIR26aFBgO7yzH7R883Hrihl46OlVP5hIgNbNufrEiToP
         Cmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636580; x=1789241380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JdpH8z6Rb7sleDgNsPa+IW/WQmX2mRqnvOWICUv+Ss=;
        b=EgvwAJtDYr5c99vVv988H8nxkNqbFz9c5dz+WDpLB7351SpfJT39cSX2oeYDb5kPH0
         F5M7BD8teLvTx5x4i4gpZ73tEpdQbiYa/5IeEIBiTCy4130zl8dysJZe2DwbnT85hobh
         Gkd4lkbDL6+NXW7tXefCsOXlI4gJuJtjCUVEGLQv1j6aAspmT498E0p5IJXjs/0j4rrX
         PKA10qwOWeMf8XgJZebP5QecbfcBTwAEw9g30y4c2ayJYfNF4ZePpf0dMmUb8YKEqIdd
         uqeTzail+JBvNGdvguTUvv9ZKeUeNVzg9Oln4WiuiUMjYAfcpDnP92PU6bVkBHZr51TB
         nPZw==
X-Forwarded-Encrypted: i=1; AKwUvBwZMXJ3wAIGAJ5l/NgcHGUtcr4H1oZjbCtZUZMatOhxht9TSTpZP8C9txU6DEsTScP+OuaqaJkuA7ALWIoZBWM=@vger.kernel.org
X-Gm-Message-State: AFuF++lc39T7A2kFsJOZAR/9pGQU1l3QcIBDEjPBFFfQ36nGreOfoBd4
	KYPxG6Z19Wd5UtpsedZ8jykDiu/EaPloiMQoBIY58jFasQIGw5QZ3mOd
X-Gm-Gg: AYBFou12IbBSptqGUoPPu3Z1shZRAMbgvBaNjlxOOnouTVTIGMRehNapS0DCnCZKbo/
	D+t04EEaqQaLjFNeDGtA+OH6+fM+yK8SMXd3ESngWgi7jjO4vng8/E6xiaaTxBIA5QHTA818DBW
	PK0054oFrXA3AIHUJO3ipQTBZjo3XlW3RLIFAQMYyI6F8WS1VKclfeHwBMW837lA+radvpjiVGC
	Uw64C/QwKYiG62ENrqvq0TMOyiVpi4zFtTbJC9nVfWqk6g0tc9pXpFwZTiJjr56rVd9OML6nloy
	vID9q5mlF5Pt7syjILtiVBpbQtd0XaZi0b9RJafa5tuFii6N7gRnN6Z73x8RbgeZD+/RRYQlMH7
	g9AtOtCbB1Tm/t3aZkIsGrykjeQAZJSRZsiMBAQaIXRsVHuB7zRHFSFVUPNiiuBrj8quxMN6YHp
	QiSukqw4UWRNR1TMyTfTdAWUX1pJyhQZCnSLG/gdlR/FDHyqiJo8O9s4vfrd9e
X-Received: by 2002:a53:490f:0:b0:66f:c1bc:4094 with SMTP id 956f58d0204a3-66fc1bc485dmr2007771d50.87.1788636580506;
        Sat, 05 Sep 2026 12:29:40 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48fb6d5sm4938594d50.11.2026.09.05.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:29:39 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:28 -0400
Subject: [PATCH v2 07/22] alpha: select ARCH_HAS_FAST_MULTIPLIER
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-7-83e8245761a2@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=d64vrkzV8SwOJMlfAMFEdEJjMT39PCBSfivQv0NFu/w=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E52OS953f6VlMGdbfOOiZqUx+b8/qvsEHX00sZJp
 28vXqD7v+MjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCuMVRnZHhVdITDzN
 X1/ZZT7/jk5OsuOnjyCsousnkdKlJ+fmvWU05GhlWLgz6/ueSyxFBtt1aHXZf9g7iqWEbJAzp/n
 s9ceDK2hwUA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

All Alpha CPUs have hardware integer multiply (MULL/MULQ). EV4 and EV5
implement it in microcode; EV56 and later have fast single-cycle
multiply. Since no EV4 system is likely to run a modern kernel, select
this unconditionally to enable multiply-based fast paths in hweight and
string routines.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index d039b7135d18..2672971b83f3 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_OPS if PCI
+	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_UBSAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT

-- 
2.54.0


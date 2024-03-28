Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB42B9A8
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608188; cv=none; b=BosaddXFnF4l8Hl5YM8uHRMkM0h3XiUlCT8PbxoNSCvX/Hq48gdh26LmejBui2XzLY/4fYrtnSRwxDU4l/e7ciRJFSVt0JSpunNb9q2qBs4UbQOcRJStuaUBKVDM8p3QXhMARerWNZ2CMsEqGIQv+E5z3m1U8gyzmHPK4eGLCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608188; c=relaxed/simple;
	bh=6hpZTtVg7DBigESi1cAJtwT8SmxuOgbugRw5UvIMzsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aR2QEltzk+g0LL57u7ovKwu0Ru9wpInL9xVbzhVNj+/BNkKP56+Hdr/oGUvu9sR4CKVCjyonVz/PtBNACBdBtBVdQkx56MR1kwL1imOZy6yR5GPBasaIIEAO+TIvSQWBAdAs4R8AEh/2SLAFH50Xru8Pyr31vLouYQyEzFa7s/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1njjI6LS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1njjI6LS"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1038023276.1
        for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 23:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711608186; x=1712212986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pmZRfwQqC0r+PYK2LVYGrEcGN9aIJWj03b1dC2yPLlE=;
        b=1njjI6LSRrdqz7cHUm/9i60QScoMeA2OWQUkheomigOZHyHSDFcZF5n7ekgK80unJG
         Hcu8EsL8oSWzmOfJyT4BEHgFASf/4p9EkO3xDuJEAC23okpUR7KoxfWT7atMdXzWi5L/
         kVhqCFcFFM8wUqak6yxBywfV0xpfMusnjWFS5qYsjuLDBbgB5o9dxF6QwxhmO1yDHsF/
         hqKG5683z2sJvp9wE5QSpP0aNaAwGVqStiIX+6dkMFT+vAtpJL3fJPJ6k7GMQLV244pZ
         ajhkIE/H7x+C5qP1QmdtUcxa2PyH9zBXr3UDFSZu2seXAa2wknc9aFDfAUruyDxYVYYE
         wjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711608186; x=1712212986;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmZRfwQqC0r+PYK2LVYGrEcGN9aIJWj03b1dC2yPLlE=;
        b=OM4JzJot07+Yb8yMs3fx5J+rDiEsGH1MdQPD1OTsqxjAdIZAD8idjykeswK8RstUpj
         365HkLOmPAcW9h6PlUOINni+RUa0OJd14Lt6SX3kwN7WXKElvE7CeaIrGG6zWatjeccL
         NFYfD/X29jJRzjffAnnc2DrcU/nzALWQRUN1/+ehU0TP4E35xjro/6G17RNWoefvccO3
         qrFtLZNIKmvtfUWjLn1tWcvfeJcHvbWPa8DCQrx4JKUQuMKamChefI2Hnwo73Bl8YdAw
         Lprwici2xe+W3l7gLu7FqD9gc08XeWn1HR766ItILWSOIzcLPh0b23Gfyvbny3XbHe/o
         AtPQ==
X-Gm-Message-State: AOJu0Ywd/pS5MU4sbgL9DHheH+saMVIZBFkjzuOSfSTa7W0qP2B+J9eL
	mmwk6I7MyDMHWrjo7NFgvaoE/LNtd96ZorbV7A5O38hNPnhNqPfa0MQax+aiK2aNfcvZjMpEAU3
	bOa5pVzr/wNestD6oBcEZ5j45q24IW9WXIHftdBBFWxDtmQPiV+BEiltPndyeUvhDO4htotH1Rz
	3scKg1OCm9sgv8G1mZtq0varvTEiAtmvvn9w==
X-Google-Smtp-Source: AGHT+IEIWxqsw6aZUc5toAwEr6h8i4YlzAtlPm6RiOTheZrZZ/liER36onbNeqtuRC3ksBNvRBMSjoCz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:702:b0:dcd:88e9:e508 with SMTP id
 k2-20020a056902070200b00dcd88e9e508mr653277ybt.5.1711608186267; Wed, 27 Mar
 2024 23:43:06 -0700 (PDT)
Date: Thu, 28 Mar 2024 07:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=ardb@kernel.org;
 h=from:subject; bh=cIGqJV3rxKfieDaf+vcIrdgAd6gKVSXsQlf65gRhojA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY1VsHDpuTnqi7JC+oSXr9c8w39AeV6F8hWB2+oqIhUhE
 UsDLtV3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIn4LmdkeGq8Kicl5kryR06V
 xzr33/y9za3xUb1XsCHI57PZxG0HNzL8Yj5/2FPAcNms+c5RFc02woFm5VKhdf8/Ssza5iHHe1S SHQA=
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328064256.2358634-2-ardb+git@google.com>
Subject: [PATCH] gcc-plugins/stackleak: Avoid .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: keescook@chromium.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kevinloughlin@google.com, thomas.lendacky@amd.com, 
	Ard Biesheuvel <ardb@kernel.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section carries the startup code that runs with the MMU
off or with a translation of memory that deviates from the ordinary one.
So avoid instrumentation with the stackleak plugin, which already avoids
.init.text and .noinstr.text entirely.

Fixes: 48204aba801f1b51 ("x86/sme: Move early SME kernel encryption handling into .head.text")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403221630.2692c998-oliver.sang@intel.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/gcc-plugins/stackleak_plugin.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index c5c2ce113c92..d20c47d21ad8 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -467,6 +467,8 @@ static bool stackleak_gate(void)
 			return false;
 		if (STRING_EQUAL(section, ".entry.text"))
 			return false;
+		if (STRING_EQUAL(section, ".head.text"))
+			return false;
 	}
 
 	return track_frame_size >= 0;
-- 
2.44.0.396.g6e790dbe36-goog


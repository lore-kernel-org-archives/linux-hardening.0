Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281CEDDA6
	for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdy4TY5T"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431E139;
	Mon, 30 Oct 2023 02:45:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c52289e900so8647631fa.0;
        Mon, 30 Oct 2023 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659139; x=1699263939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roNWFMRIdrA2XJQW3qCZb+P5wFturM6emUJo4E5vPqI=;
        b=Qdy4TY5T+sQo1kfvTxNYpgmNWdFzuq5emI2aiCbKbKW6tdaCXuIis4ooVcVZ8q9ZRO
         eoWm7AxZkczj1Ud0PZ8HkZwOkIpZMqXnpg1TaTTOcy2wQ324Vlxq9JineE/BWXYz0Q1n
         AnanwTxueMJvB7ppgkNbVt0SDovUwp3JXcsjwKbWSGgwWSgWfUjGD1YPR2NaU+T4MzxM
         Kp5bLjzzRO8YoMegNPMGtG1f+D0QHOQ4HXE5U2+rMYif2W/RfV3vyVRnK642ZjN2VPMq
         qTrAn8GnADrEmp5DdhDRtW7iD14TustuF48KO2ckug59uJuDB13mKDFtmu4rC8SKOnaQ
         8Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659139; x=1699263939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roNWFMRIdrA2XJQW3qCZb+P5wFturM6emUJo4E5vPqI=;
        b=QtQHT/ecPqiIvvSc4LaUQRiCuOGEyk8YNMLsbBfqsNxGfQ2J4TrJSCDPMCjkz89AEW
         w4DxeElpHBnHEhZ2BlhrvwAjoOCTA5wcEBqUnxixSsmRR0yfHFTuYtT150Ys7lYOAGQq
         I1Qjvd+P6vlOawXMC2AQvriN3LAA/pXulRGHwvFBSKULAtE3pEaMAx7zBxudXxMvmQB0
         1Ifj17Vlhtwp1bzbkYfpaBfvQTG9Wiu0KIkzr6Y6vOTyo2aLdKobh7M0dZjjH1gUtSZR
         g39dd1CTlRhNXSu/UNPAQOnvuyShr6yxgIGvkA6Xn0W39WGVwKFKCq2DNgy+9aX2I8AI
         grkg==
X-Gm-Message-State: AOJu0YyDNeTfgD9wKVwIkzTm0DXIpnMMCIb7DOyq+DRqNgAXImSRqBo/
	ypU8CqzmZ7smYjZVNyKmklbu30FPgckqwA==
X-Google-Smtp-Source: AGHT+IFlD366l8eXN2XK8pK+fCHY69joDXkYrc265Zwn9kNPlFud5PBYeigDyU//8huZ6seoEXmCIg==
X-Received: by 2002:a2e:b531:0:b0:2c0:1cae:dd3d with SMTP id z17-20020a2eb531000000b002c01caedd3dmr5732749ljm.4.1698659138776;
        Mon, 30 Oct 2023 02:45:38 -0700 (PDT)
Received: from localhost.localdomain ([94.141.255.13])
        by smtp.googlemail.com with ESMTPSA id w16-20020a05651c103000b002bcd94f9714sm1243216ljm.126.2023.10.30.02.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:45:38 -0700 (PDT)
From: Konstantin Runov <runebone1@gmail.com>
To: keescook@chromium.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Runov <runebone1@gmail.com>
Subject: [PATCH] Fixed typo (args -> argc) in plugin description
Date: Mon, 30 Oct 2023 12:45:08 +0300
Message-Id: <20231030094508.245432-1-runebone1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearly, argc should be used

Signed-off-by: Konstantin Runov <runebone1@gmail.com>
---
 scripts/gcc-plugins/latent_entropy_plugin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index 39e86be60dd2..ff0b192be91f 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -17,7 +17,7 @@
  *	if (argc <= 1)
  *		printf("%s: no command arguments :(\n", *argv);
  *	else
- *		printf("%s: %d command arguments!\n", *argv, args - 1);
+ *		printf("%s: %d command arguments!\n", *argv, argc - 1);
  * }
  *
  * after:
@@ -47,7 +47,7 @@
  *		// perturb_local_entropy()
  *	} else {
  *		local_entropy ^= 3896280633962944730;
- *		printf("%s: %d command arguments!\n", *argv, args - 1);
+ *		printf("%s: %d command arguments!\n", *argv, argc - 1);
  *	}
  *
  *	// latent_entropy_execute() 4.
-- 
2.40.1


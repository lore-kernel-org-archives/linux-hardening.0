Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFA3FB1F
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BC6d5eOU"
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3AD43
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 16:19:19 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-581e2609a5dso2362818eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698362359; x=1698967159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJUIaaq/oswhFA94o3ND9d9+Iexffy2MpltZ9TbSQQY=;
        b=BC6d5eOUbpZj2EhbDkCtoVPkarvXcccoL04DzKW8pl/jhqx1Q520C4Urca1Sko4OKp
         bavNq0XNv/2izUivQLIGWWR6M3faFCIa7rZ9ZBRM8mi8+aEFeTs5eNZzFR9nCX3wdkjF
         uThlr63OwueeAPgi/UTizMQ3P2jeEdcjoCj1Xo3+na26rAwqxQGfEgC9UtLPv3sarxqq
         v8LoUR9ZKTSAtLv0dBohaGBlqWXihME/P2Y9Mfis07mDh3MfCe8OfXfq2Zk1bk9hrAvQ
         sYWc9AEJeXa16H3UgQvsmPj+ARr2tgzjj9sTZ1AB+P6NQPJxhUWYKAFxA+HRDppn/Px8
         KzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362359; x=1698967159;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJUIaaq/oswhFA94o3ND9d9+Iexffy2MpltZ9TbSQQY=;
        b=D11JgMQSERvs+O4CoVYhZYPZ5+IvVEUTFamDQmsrwP94cUivZbTdg28Ck6Okehx9Li
         9aKvjBMLKTHy0O/olHaLtvFU/EwrKznliE/44ttxmsNUSM7/xAZUve0t4NH2HoZKFknr
         MT74kWnZVHvPPUSiBhjsTMA8PXmBu8bt7bqfWOXZabe16btjq3LTSaMzkZSKgQXhd7M7
         xQ2UaJsTDqwq1aFbxZBYnO58/RQBqOrFT13Pe653zE2/KXRRWvaoYEueyWV7+Ksqr56+
         qiIqW0I2LXwRkdz9J1G8xCcsTzW7jHcoc2Q7l0qPc+6Go1Bz0LP4ZpXbDHHqoCRaUyG6
         1yQQ==
X-Gm-Message-State: AOJu0Yx8B7sc3fXWSgornaZcFStvKAh5I4AqxeAPh33xStD9Z8fdAnMJ
	JUJ62LLnC1bswFtr75bgj1aQGOG5EmkpfhPrxQ==
X-Google-Smtp-Source: AGHT+IEn/SLjvxaFs50tSZC9lk6X5MyTWbZRithyR/6U6p23lScjjTmjpQ6xvz1RXCrqGehDHbWGiifwhVwJ4bGNuw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:e658:0:b0:581:dbb1:219b with SMTP
 id q24-20020a4ae658000000b00581dbb1219bmr404827oot.0.1698362359119; Thu, 26
 Oct 2023 16:19:19 -0700 (PDT)
Date: Thu, 26 Oct 2023 23:19:18 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPXzOmUC/53NQQ6CMBCF4auQrh3TUpHoinsYFtCOMAm2ZIZUC
 eHuVo7g8n+L921KkAlF3YtNMSYSiiFHeSqUG7swIJDPrUpdWqNNDbJwcPMKnikhCwRc4E2ME4q
 AI3EROuIIDry+Oa8rrbsrqvw3Mz7pc1iPNvdIskReDzqZ3/qPkgwYQHvxVW/7Gm3dDDEOE55df Kl23/cvKrGXxOMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698362358; l=2719;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tC58vKAxLJm5cAdnZ9rYPmKDTa3guBZo7Oh8cfH/AXg=; b=xW/7pk2zSIdbdaANtOGtksyMjVeqD8M30IczBSFi365yP9f/D8GLqCR5vqlPF/2OcBvYQdmMr
 CAYKpl7GFTvD4/4vGd7LbAxPSijXKO8qWqRTUeMAOjbIl15/K3OHB/C
X-Mailer: b4 0.12.3
Message-ID: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
Subject: [PATCH v2] airo: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`extra` is clearly supposed to be NUL-terminated which is evident by the
manual NUL-byte assignment as well as its immediate usage with strlen().

Moreover, let's NUL-pad since there is deliberate effort (48 instances)
made elsewhere to zero-out buffers in these getters and setters:
6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
6130 | memset(local->config.rates, 0, 8);
6139 | memset(local->config.rates, 0, 8);
6414 | memset(key.key, 0, MAX_KEY_SIZE);
6497 | memset(extra, 0, 16);
(to be clear, strncpy also NUL-padded -- we are matching that behavior)

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

We can also replace the hard-coded size of "16" to IW_ESSID_MAX_SIZE
because this function is a wext handler.

In wext-core.c we have:
static const struct iw_ioctl_description standard_ioctl[] = {
...
        [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
                .header_type    = IW_HEADER_TYPE_POINT,
                .token_size     = 1,
                .max_tokens     = IW_ESSID_MAX_SIZE,
        },

So the buffer size is (strangely) IW_ESSID_MAX_SIZE

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use IW_ESSID_MAX_SIZE (thanks Jeff, Kees)
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-cisco-airo-c-v1-1-e34d5b3b7e37@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/cisco/airo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index dbd13f7aa3e6..6a099642e854 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6067,8 +6067,7 @@ static int airo_get_nick(struct net_device *dev,
 	struct airo_info *local = dev->ml_priv;
 
 	readConfigRid(local, 1);
-	strncpy(extra, local->config.nodeName, 16);
-	extra[16] = '\0';
+	strscpy_pad(extra, local->config.nodeName, IW_ESSID_MAX_SIZE);
 	dwrq->length = strlen(extra);
 
 	return 0;

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-cisco-airo-c-d09cd0500a6e

Best regards,
--
Justin Stitt <justinstitt@google.com>


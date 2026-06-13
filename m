Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A733E638E
	for <linux-hardening@vger.kernel.org>; Sat, 13 Jun 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355871; cv=none; b=J0ZnJbzH7EJDXX6SLLQMNOs0re77XJtOlkuSRS+lSrNM/oMNwPpjEh3QqOsTk1SfRDHR2Nm4dOgRCYPQhugtneInVsE1EJhFpKDlPI/OpD5fbhxhs1JPV087wriuTNDjsOGehMLw30z86yn54sSAAyVXqjhNDdhexL9wuNfFHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355871; c=relaxed/simple;
	bh=8rdVy967/KIekFumWZJodjNYinOgWN/JZjf+3u7FmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJUabCr+ZRLw6xcuqjDh78PnUKpY0hhvEzwUwK0GUhp9zW8S90O/nHN7wQC2wJ35FMZkQGDR8TsdCtcyMPafHR/Btli8pSfQGG99UxjshSAIe6m+kzmp4+kiem2YybXqvpPTCHjY5CApIkLr8bfsaXgjMtZQVrVH8++MEBJYCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8ID2Prw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8ID2Prw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so8365675e9.3
        for <linux-hardening@vger.kernel.org>; Sat, 13 Jun 2026 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355868; x=1781960668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNHff3ZA1wnEWNCHL45Ie5KO3LOfvKjTR8zIU+k8sA0=;
        b=n8ID2PrwDMHD33lC0HfluqTgB3sNLcduK66hgkPgk4lz3G1OV3utNhHABA4/xzHoNg
         /Eju2lWceIX5YLnpV2IcDjvw0zlEFSUu8LLick6NRa2htEDsdTTREC/j1PsNGr87Cfu9
         JjBoskdoWPdv6jcu2TSMHmDHd0eLCzCqgX5drNOWuD3CgZRjDF0FsJQT7cAmv8nIsIDU
         6KHCDGrPry4mXvXlUKtp9bsXE7JTDSQjSeg5Y3jSasWoKwuRvt+JiXIihqFrNkmG9M/K
         mzBgeE0sBFZI5FXrA/v/s5urL3BOjqXlZ8Uqh2maEBPIpZbC7qt4rGEr/0d2DtaijB0Q
         mvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355868; x=1781960668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNHff3ZA1wnEWNCHL45Ie5KO3LOfvKjTR8zIU+k8sA0=;
        b=HIU9+g7l0g5DFP9Mq+5mS4Z0xIeJZn0Mq2Ux/aa+ONlZxUJsBKAmSwr/RBj/kCSECT
         K2VSOA947OIV0V/6+KvQ6DJ7L+4RTpoom2H4i/RXWL7BwYF5x6uVZHhBAGdMydYcUVVA
         LU8jVjlWyloJajZ8/UgJ9XzInvJCuJPkV6yWItxWzj0USfxXeYVBmzDjZQLGPFd9C1Uz
         6d/oTNjul2zMJu6GWq+6rCrJ41F/vF9ssm7YtO7GzcbJ48HKljCeMCBRvCa3xBV2HrnG
         tiZ0ZePfMFktJkJECQ3IpaojMkElhHNWUQjhMjmca5hBpTWbV4qR8YEVbPhIs5fzNN7R
         pSPg==
X-Forwarded-Encrypted: i=1; AFNElJ9HVKwPM8ZQkmMaLY+hice5jYf0DjcPXlcvqwDAIVUOV5GMOLnjEj4pMLfH/S1bc5AqHU1i0UGsbRlqDL5qM3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TiQlTxkZlIm+KxhpQZPIqn/ICPMghi1RQf0+iBgXMjqIweGQ
	tUOyHwpJVs7cRfc5COsBId9zg15cFFQolRbyiDv7atHTYGk9PQMQClQ=
X-Gm-Gg: Acq92OEmqGexQ3lhZe/jHs2CCVudUbc8lG19CCjdK/QgabFglkMab41dQArUSfFjwIM
	PZ++wqKsBoiKBYt4AmNT8ePFAxUEbur/q8ZRZREWdw+XdqSY438TC0lRVp9Qv0m86xL+KrslG5E
	JO05VrDzbI5ALHBeYyX/3lYjJGOIV6w1H6cMksDwx5aTxy0ZemvrTQHP31pV1WtlQzE78cxeBnT
	EnksBt5jPOjbTShdBWQlRxgnHGVpW3R9hFOJ55t+NTIJ6hq2pBgLoWW+8VEmEoGS9WTbruyZjmP
	yC67qEeJTKubnTtOxjB5GuBz/d2EzU4ccMN4FFnOy12fbP2mKeELdX8GYIb7sLOTMEAbrMTVQCa
	ZycnTTlc2DOdEHfDx3rwQVlY8MEKGAmSLnWvNaaurptejDYnUaQijgLrwK7OY4qnjOCPElQqM9A
	OolJoFNQareKnmnY7f2WiJySrQBC4QONmYqfnM0lF0purcM6wcX6aKKl19PZehGgZw/LIe//KCi
	k+BvKkFhdxG4EVanA2kdNGAgqEzvg==
X-Received: by 2002:a05:600d:8489:20b0:490:b724:507d with SMTP id 5b1f17b1804b1-490ec4cec11mr64189855e9.11.1781355867847;
        Sat, 13 Jun 2026 06:04:27 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:27 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 1/2] keys: request_key: replace BUG with return -EINVAL
Date: Sat, 13 Jun 2026 14:04:07 +0100
Message-ID: <20260613130408.13709-2-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130408.13709-1-med08elkadiri@gmail.com>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG() in construct_get_dest_keyring() default case
with return -EINVAL to handle the unimplemented group keyring
destination gracefully.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/request_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18..fa2bb9f2f538 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -332,7 +332,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 
 		case KEY_REQKEY_DEFL_GROUP_KEYRING:
 		default:
-			BUG();
+			return -EINVAL;
 		}
 
 		/*
-- 
2.43.0


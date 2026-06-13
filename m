Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2973E717A
	for <linux-hardening@vger.kernel.org>; Sat, 13 Jun 2026 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355875; cv=none; b=rBS5DxbTjorpRX2uUas1D/Pv41XF7+f47P5cVWuGzSPUOXhC3Yhrzj7VAbPvSTnEwJxnM8M/iiTsh606oWLFMBK7iH6f5+ZxUMzb/Nymzct58rhD7oAev36uVrZg5S/6tX8j5C05EYHcZodhf2RJ3zLEBhWrHwyVPlbZEWF1w0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355875; c=relaxed/simple;
	bh=3vvntg+S2X+Ax/eMsRRgfXIb9auW/tXA/R5dpCGI/5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuOf45X84ImgBSQd0b8AfGbqbfDvw8z3Ct5aQAX4dPqU190AlaObCIDdXIv6Sl4xdDQooHAlN+Mv5qX+SFJIH/6s81oNcloR4y3jhkxcRVOCCV3/l8baE15xdz730jrIvmsBcHAAupeGgPhT1tKoVjtuapbmIOxgQExCyUiQOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtSeXVka; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtSeXVka"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1757910f8f.1
        for <linux-hardening@vger.kernel.org>; Sat, 13 Jun 2026 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355872; x=1781960672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNuTD3YpkBdUsN3SNTli4o0UK637uh750gxlUeSrfmY=;
        b=EtSeXVkaWCF9Qw3BXu3nd38sotcl/2lSC2GWMZjEUdfJaAoMI9/JZIsftYuRdB+6Z9
         waqpnD5fcdQpgeuQHG2XM28IeIoYtBi9Uss5YhGMs1CqMJI2eJg2VrjJw0VltPG3Y5zb
         EYXWN+WKjXR6s7NqhhDtDOWtC7Jd+WfufqzcuksH8xffZzVv3DqI2gAjrI6qjcs92sl4
         l4uWNEjNjgMVYFZTy7ICKgVOXR29AYr2j2STolTsn2Hgq/YQ32gYGIL4hZAA4HOTd76u
         J0hkhoLfAxC5cDd/bT7ipSoFtPAqQbw9FFXdpHFJ4UbxHpl3XxOYbsG9DQMzYgCaUPgX
         zVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355872; x=1781960672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNuTD3YpkBdUsN3SNTli4o0UK637uh750gxlUeSrfmY=;
        b=PYAOLDHEYeoSasGJTtYojqrFI4WqITxXJcC2lUsz4Rkx7Lmkyau49ZJ64kqXGRjyHA
         v8Engmof5AkW42ahJinR8gcD/HDIi6Uzsc4t199eReA7CFK+MjzPBZXXTWhvgIntTskD
         4Fov/u5vU6xuFdQz5QOIjH9bz3WLstDMFzSjDFU21M8Z8Z2xvq8OhDfzUVgFes2Pca0Q
         OzAv+WMSM9I42+WE9eeHGfg6CcMHXiV/Gwp5rWmgNMcsb/zCi2G6wqjbmi2bJBlLKag0
         Fgte+1O9UApMYNLa2erK73YU28h3bJFDig3PePdaPfxfHkLVxHb7EGcwHnYPxgOQHtC4
         zElg==
X-Forwarded-Encrypted: i=1; AFNElJ+pB+DB/3TzvugLYZu5KHYHaajl1RpAQrbNvoR27qsVcGhC/fpoROV3L9NbNy2EeDPVTJUeaZQKy2rt+WJwrTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArVNYPhSufNnZ/Zzufu91/rEimgSujLbUWXLZnOpUI9z+DUIw
	kZlgxQ2sRXd9dEHph27q0M5JodFQLuaC0KfiV/9uc0UVMC10k8FNIbI=
X-Gm-Gg: Acq92OFSKEukyABW7Lm45DVG1jgtDhwVxAmb+GHl6ssuY42fk3MyxO94ggajYctutnM
	Ti4NQyFP4bFdyLstAuKl76Wjh4CLSJh5K1Crgbxw2hJKMzs5YaHQ4XEACc91OL4VvGe1DpIHFQC
	kSRmlbOfN7gxM+Ms6QMF4Noee1gI1QikI0rQPl1Ie8ebK9P7b93n9KaIuuu9Oot+P5NGjfLOmHa
	ojDPyTLfIG1iCVSD4gFvrND095f7ts+RcXqyQKQGfFer+wSfgakCcAdIX8CRxdJomSdP4TVe73G
	vrLfTDEY83JhT8Q6oHoK2FmvoL/X+DvmAqXvJCqhvuzyqM0ITcJRX3hr6y8mw2+fs9MzCzTczID
	7EqBn7+YlcxpMY4kzJ3PzhICKA2JxYFbwYMAdFnCZiPxb2K9RG8iWb3j1kbjoYo+NulQYZsAC0s
	vr+nmaUJqZGlJVTN7KMnQjKr25lsooEWNVz5qWVIw5FWWOqG5qH+WXGNKxcsd04/ycn2m6d190J
	P3LCymPtjTZrGIpKCSLD/3qdOBFsuwbtrBzNj7e
X-Received: by 2002:a05:600c:8b5b:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490ec49f2bemr76562845e9.8.1781355871908;
        Sat, 13 Jun 2026 06:04:31 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:31 -0700 (PDT)
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
Subject: [PATCH 2/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Sat, 13 Jun 2026 14:04:08 +0100
Message-ID: <20260613130408.13709-3-med08elkadiri@gmail.com>
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

Replace two BUG() calls in keyctl_pkey_params_get_2() and
keyctl_pkey_e_d_s() default cases with -EOPNOTSUPP, matching
the error style already used in these functions.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyctl_pkey.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 97bc27bbf079..6b2821ffeb6c 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -155,7 +155,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 			return -EINVAL;
 		break;
 	default:
-		BUG();
+		return -EOPNOTSUPP;
 	}
 
 	params->in_len  = uparams.in_len;
@@ -238,7 +238,8 @@ long keyctl_pkey_e_d_s(int op,
 		params.op = kernel_pkey_sign;
 		break;
 	default:
-		BUG();
+		ret = -EOPNOTSUPP;
+		goto error_params;
 	}
 
 	in = memdup_user(_in, params.in_len);
-- 
2.43.0


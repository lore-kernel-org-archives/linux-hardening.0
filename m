Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3581C548B
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514523; cv=none; b=Dtyg3CHaT0c/8WyeQzTvfs9sHIlUZXZDp53KL0mtZPb8esI3Rxo9Z0d2OXRVQCvZksoj/wMBuIsXZAAMB1ITe3oyuDChyYIFHvjs7K8it0WDhtDUGRkDOac7mEZXMsMrwk0+p4tPBP3Xt20SujUjEfJJddCyAqd8JAtoUmJVfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514523; c=relaxed/simple;
	bh=q4U1LXC8ox3d7UwtdidJGxH/oi2EvLePFYdjxr+tYug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBQcE0qTZYcVT5RIwIbNIdD/xRwEwdm3uBYYCXYQD6nu65ljumGpaiFj8cjVFamkbgoB/8wKlQTUPhSROBwM7N+4yXfEweYxC99pzPXeXeR3qXPlxM4N0r5nSIcwIaLfd+GhU0ypZhmHBEWb6AtjiOcbAXtL7huzhResdbLStrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AIkE3k8Q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIkE3k8Q"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso332332a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733514520; x=1734119320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWHOSFnp6YO+lsoFcP0qwFbbFIGSFxBuBWk/HmNV+8A=;
        b=AIkE3k8QipZUTwj+8z9mcrbFfFMGUAzFaMzDK/7miqwpBT871sKq4c+Miqxc+ZHWd4
         RGYqOWy/cF+AuvFasqTSwAni2mZBtKv9FbGPSM2ODgAS4u9pqmPKGB+LDLfoI5CrL7ng
         Oa7aPRujZbXaoaLpy1ut91AqpXa8ayS2aN+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514520; x=1734119320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWHOSFnp6YO+lsoFcP0qwFbbFIGSFxBuBWk/HmNV+8A=;
        b=RQIuGGg6STsFWx1elN5O2vlbFQwUqORB69IQOjOWuHSF0whQG5mBeRHyFsjpdjJQXs
         f6vOrk/NUdohy+Eq1VRpjSeS/Suy/AkpXjINvXoFQrMdNUaQbnuKrQG/mwPIUGMRKXHY
         ocpF+VrA8+D9QVomTDI4fsPBbds53oBDHxtIJ05z/crSYMD5IyLxg6luRSUzmJyh4oxl
         td/DLGfAkn/IFw+dMdmzcwIPpcpw6Qfco5rkP2TcqAUNHO+tOawbYAZVPEDqJOJ8utxf
         CK+NU4bjYxQoVrVUGeyzJIwARRHnUelJEAAeoWDQZhNfvTHnqqGqnCgFPqJ1j+BnHhYu
         h4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCj7dV0hyYaE5OepUpb0CYSg/JsqqegmXm8Y2GEQy3OW0QbX1FjkCGxyPhsva7Y2YE6s7qWz6pYSr2t9y9PpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgRoexdZeocWEMdTYgY4d9VkwQJFJyaXNObPdmBjnJtrjs4ZX
	nJlYP4rfOkat0AUPbkG/DvmReQ4TEfqifsbvBtfNCkrGlPNYB8XF8rWp88oNsQ==
X-Gm-Gg: ASbGncufIa/8DLjQ11Y0jphwfhvyp5zeJ2YFbC5eLOKNZR4Ysp/QykHs3BnMXlgyhd3
	cS0Zsm0kDUZfVLMsQJrdV3IH35d5yt+T2TNxVipILSPokSoNGaeYoQ2joeehY40gBL9OFx7MUw+
	LSA9Q5nytpcOaH7VSnI6hRehYPoVG7pPThyq/CmEQ8IqO23yVZWCy74+3+PXjRvB07OldCm2vR3
	JKwlhl7k9Tshp7dYZXYt7Dqj32eNhFbLYZNdqiOEbFiWlVEWda4w1DGqSeRDVoOhuXxW3MrBbCj
	NivlzXxIf9w=
X-Google-Smtp-Source: AGHT+IG65sTKlmsqpI7GdM3gNDUVOxz/ZHodlOQCUdzYHPngVaIbt2p5YZVSA9/sCstTA9tW0wBaJA==
X-Received: by 2002:a17:90b:3910:b0:2ee:3fa7:ef23 with SMTP id 98e67ed59e1d1-2ef6ab23270mr2485494a91.8.1733514520663;
        Fri, 06 Dec 2024 11:48:40 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ef45fa64e0sm3536432a91.26.2024.12.06.11.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:48:40 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] remove can_do_mseal
Date: Fri,  6 Dec 2024 19:48:38 +0000
Message-ID: <20241206194839.3030596-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

History:
V2: remove the can_do_mseal (Liam.Howlett, Lorenzo Stoakes)

V1: initial version.

Jeff Xu (1):
  mseal: move can_do_mseal() to mseal.c

 mm/internal.h | 16 ----------------
 mm/mseal.c    |  6 +++---
 2 files changed, 3 insertions(+), 19 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


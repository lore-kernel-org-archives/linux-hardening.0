Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99E50097A
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975915; cv=none; b=ofOsE20rdXQs85YA+zE9GJpV90558lsgSbjoNQNx9KFW+ZfjitIdZzJM3OPUAXOjNf4BrsgkyFpqBJrpyM+2LrURTThcAp4lcXyH757mV8mU4/VqKLYcx1fqREmi2LV06pYJkYEfZAkJavIJcE2ENB5xxlIZSvGzWT4OPO09bfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975915; c=relaxed/simple;
	bh=Or8X45fb6JlVhvwqZAuCoEFTeOy7bGSil/GKg+EO6P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1UToRh0MGe4ynQ+Y23rRqDE3NIsr4vaJUNlMNCWL8O21yMWDDG4GTgUvZiyt/jMMNVnDbh7mca58z0rOW/s7kGpBqX85pryaFInJ1QrnU/5VjTOdwuJE4ZttH8Fc2mZKpO93+zJnJ1/z0Rwt0DEoGiWpQ2nI8WGCd3eYq/Q6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMMKCFnB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMMKCFnB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-431048c4068so1975212f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767975912; x=1768580712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6D61jCcPKdIzLOh1VTWA3yx/fr9rhqVqmFGIMjfLvdI=;
        b=aMMKCFnBkmxn4AGCpgSrpRFjV7QMPvs2OZDEWFqMUbI1OwAzEPbYDqDgyf3VelNMne
         O15hjCmUIhq2R7AY0laRbYesA1FhGzlqXSSPCEY5bELtSmGzF1M+6Iaeh8wQYIw/hRF+
         Y3l0KGnrcaShQ8/2HpOxWu4VR0tFoEqRokEkFTFUNZadvVluqUnkeY/zT1s4XmW93h2U
         yY4pmU4MldfSgYtjt6zBjtpFMa35L45m8rFZf8zJaJFChdjY3fXh/7iLlprw/wbuQ4ST
         700zoBzrnTW7u+sUxenOA5dUmPbpEoQUPJmiHcEK1OH/4Vr79mSXFJploSDWOq4cJV6U
         Nlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975912; x=1768580712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D61jCcPKdIzLOh1VTWA3yx/fr9rhqVqmFGIMjfLvdI=;
        b=ZI+Dbn8GmfzXN/gIdSCvdmg9P8JO7myCuRsXFm0BmAEM4fBOru0YeHh/debQiSzkZQ
         Dz2a6+YRHyysrU2kza4wTnlqNt6HM2LVgBHoK8/j0TXK9nBZWS2QqF78I9uchx3fZWEs
         WpJnfcfxt/DLUsgXQ6dhPp2rVRpt0GqcEl6vWwX+w+/hTx9DYNRNYeeBgMfOmE5Zkd02
         5H1V9WOnlOBkKDOY4GD/++AX2LadntDm/KxvLOEUYNHQy1/dZaMXRhQTTe7tfbRTDlVF
         7+JXQZw5cd32ntrrQIBvenQ1qZUzw79JdFlcH/pHEZ14Hl7MaO1koUyHpKQXwzfyOouL
         eFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU74Rga4TOgWCpZYnrnVF1pNtfzzZUEuG3wL8/G9ENUv2DKhMCyNyrXcikPmo58O1eGHUDP0LbMEmlCO+64aP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWjYZPWtb2mw6qkPmnsEA+CTLtBOHRnlGg9ApAD+8eqOqxsP3
	qfJaYq/XH2jgBZXEMlrt7Cj5ZRTK9AZTMTuPRQMVnfpJoQyY2xgLNL8T
X-Gm-Gg: AY/fxX5tg+5oAZFgh7W8HbjInmrmOZZ8kDV4uIw5PgOpmHyYgumd/TidORj5/DcqcC7
	jw3JX7R4lMUq/9cdNIWz4GXb4/Rc/pjxw8gipqkBHI2YrGLrBAyQ+4CXWkxykn5wKK3iwqNa4/s
	rH/DlXhBbgvuWL/t3+PyjFfL2YXqXV3vHcmDh3IUVopF0DQurXtMXnK+JPv2s4Akg3tNaIb/odk
	cXbFJJh22P/AUWT2DgUWp47cXD4nuaZbDt1H+IJB+1ZMvTqTd503oDBG4Sx6k/SV+mvKiKgn/rl
	3lCDf5biV1EOk3PLjGpYJXHk6KYefhRwfqEi8TfJdxAhKBknhuSMHsgWst7+Le+0T7EhxxJKoLV
	gQZnkdbOz3/soXUbkhcEgFi46R+FWxz+VaCMy/mygFz5wsc2mWLELrxKXP0rBrRfyH+tkL/sRJP
	jlUXwY+vjFMQVY+SP10WmzZ5eA
X-Google-Smtp-Source: AGHT+IETHFe1bt83p7OLl4C3e0be5VCh+jmS63D91zqEYAh74kxUAD5M7+gilHthbzHGo+uLzSlcbA==
X-Received: by 2002:a05:6000:2010:b0:431:f5:c36f with SMTP id ffacd0b85a97d-432bcfe4cfamr17880196f8f.31.1767975911920;
        Fri, 09 Jan 2026 08:25:11 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff0b2sm23201743f8f.42.2026.01.09.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:25:11 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-hardening@vger.kernel.org,
	Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH] drm/amdgpu: Replace deprecated strcpy() in amdgpu_virt_write_vf2pf_data
Date: Fri,  9 Jan 2026 16:25:14 +0000
Message-ID: <20260109162514.308143-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy() is deprecated as it does not do any bounds checking (as
specified in Documentation/process/deprecated.rst).

There is a risk of buffer overflow in the case that the value for
THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
replacing the deprecated function will pre-emptively remove this risk
entirely.

Replace both instances of strcpy() with the safer strscpy() function.

Changes have been compile tested.

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 47a6ce4fdc74..1c4e74e35cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -604,10 +604,10 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 
 #ifdef MODULE
 	if (THIS_MODULE->version != NULL)
-		strcpy(vf2pf_info->driver_version, THIS_MODULE->version);
+		strscpy(vf2pf_info->driver_version, THIS_MODULE->version);
 	else
 #endif
-		strcpy(vf2pf_info->driver_version, "N/A");
+		strscpy(vf2pf_info->driver_version, "N/A");
 
 	vf2pf_info->pf2vf_version_required = 0; // no requirement, guest understands all
 	vf2pf_info->driver_cert = 0;
-- 
2.52.0


Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B913AA4E;
	Thu, 17 Oct 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157982; cv=none; b=AdnPAaebtQ9PJA1dDZzkrlABIPow+4jU8+I+KZWDSH0RL3BmZSasoMRSGVvOo8E9X2OqkDBOI4WmvvHUkXcST7As1u+4A7WwknQ5k1X/8qNUeg9qg7fLJkvDqg8+u1aBpoRZG5bGL1LoDFdHcbJuaJJUOej52B2kwhtjuKI4SSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157982; c=relaxed/simple;
	bh=C42URS24IogOW1s8SLEGZKkfR7gnux1L4ZhNjBL9Ipo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LFi/k+CsiAVkpkbhi4cgf3gGRPdrW4aY0k/pG/A2/8JvQbga2vkF6OxGSPVb9S91jed35NpVXmdWrpVZu5nUyebzOLRtEnGzOC8H32T3UwpfObYZLRoJWA2kwMVSWQzfQCm5Uwyxh+NrHBQ6HxeCGL8kEsR3rQzpCAqnIqbAVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aClISKUz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aClISKUz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db238d07b3so641647a12.2;
        Thu, 17 Oct 2024 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729157980; x=1729762780; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydf94IBLCbwdFZiD8hQTnCOX05UKhFgbH1jfcRWJdnM=;
        b=aClISKUz+K3uJEBxIl8r6++G2+R8UM1y8HoTQx+i9HtLxFBq67kFLfMygB31apM7Tz
         TP6QNZXXW/e4G6HuXP7aXLi3nEsa9aiK0GAsy2H48zGjAuJaXBd7kCQfkGEgNHgPnrgP
         NGgCBk4YK3K1dLjCYZvk4JXAvrVGQ7PejNKUMMwWOHre4uan9vMJ3OsVKGHQipwcUEVi
         FL9FZPlFvNWRu2bRe7V8iLCiSL2remOTg20fn71U6N8hPYs3FM8uT9lV9qbZqbkyshXX
         LI2zcb+ICiPsvD1B9w6p4F7kd6kxGeEo7eVl7vISJYqYOI7pSG5i4MGj3gjNF74fWxB+
         7yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157980; x=1729762780;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydf94IBLCbwdFZiD8hQTnCOX05UKhFgbH1jfcRWJdnM=;
        b=u9oxhSjp33BEeWn+5ygWivKpXxrdUKbCpA+OGBK8QjxMkeeY6j83SOstR3SZooy2ri
         TPRN3Nc9svqWUitv220+/2MTlVOjmvHf/d1MwrzMsM4/kGEawKWceb2BURPVQNBu6Kxo
         mlg6skqUC9qwObQ3jxxhToUYtbJDYus4pV0cLoKeT3QTGV1SxL17ZU3SbpWpSaf6ryCK
         edH/hkD2undaSfjRfH2cV0U/W5YYFJoo2iI6ia6ntdddzesXHEOeap0x9inavD6MzcuU
         5cS0uiUO+/+A0AaNrxPgRt5OTd/mPaGAOZOyMsJFqB/70yWDnwd1TZb1iVdiJj6WDTKE
         yWWA==
X-Forwarded-Encrypted: i=1; AJvYcCVxVNkngfmFeogdb3lXebIcaKl4/vrnEw0Vt/Su3x0lQQKaOL3uJxnSnVrKuC+VEup7GUcNH41iv4ceyxRq@vger.kernel.org, AJvYcCXZU/HuVRqmTD6kDaPcgUjMyzSNz3b/a6hDnYiyJFKv2ScGhu6sxxJHuRZyU7nBRLPFlB9KU8UK6MdQvk2zd9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u6Ssp6hfkma0OnZYSCtyv+h6cwC41sIoSaT9SJu5sADwPkAX
	P+94u59q3fqLq6KpXEaf3T0njSOrlryRPz3lb8wSXDRKDVpdGple
X-Google-Smtp-Source: AGHT+IEBqVbyOoExw0Cg7ddiHiTaN0dPOHmp4wNIiX3iPqa2LS2/M7QxhxM8sS6KNZx8IP8F0Lj+NA==
X-Received: by 2002:a05:6a20:d818:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1d905f69115mr11651591637.45.1729157979950;
        Thu, 17 Oct 2024 02:39:39 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d3eb7sm4027821a12.45.2024.10.17.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:39:39 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:39:34 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: paulo.miguel.almeida.rodenas@gmail.com, linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: 8611/1: l2x0: replace snprintf with sysfs_emit helper
 function
Message-ID: <ZxDbVt6QGzXRBn2v@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sysfs_emit() helper function should be used when formatting the value to
be returned to user space.

This patch replaces open-coded snprint with sysfs_emit() helper in
sysfs .show() callbacks.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..a9bd05b82003 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return sysfs_emit(buf, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.47.0


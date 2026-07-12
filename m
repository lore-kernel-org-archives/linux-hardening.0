Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFB271A71
	for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893643; cv=none; b=Mm7CyqUItYzT2OJag6SUYbH8xTi3miJ0YC2FCsMZtZTeckCu5NNOAPc/8HuOQWRM2z6PJPX9Pd1sH7xpI+1HsZTzGXC2/6lmu6CAdWBY0atAi0EfYjuUH2MIKQEu1K4SZQGhB8OBDbzaR9DhbJt6aHGoZuBmRIRcEx+z0+YRI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893643; c=relaxed/simple;
	bh=rSZSRyjlEY0I56GUB2ttg+LeJKLDJz1BOhO4bU2aDco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0lxioO4FhCHFk6nEvuxORscnYUKbWHgD0+JnKg0OoXvkzUu6DjgjmMNh7KkPFBeRBIDmtev9Vy668nJlqV7JX3bDt8L7QUhG/yZYUK7jUsxdX7mObonvf4eEeHchCjH/NDpkOdeDk4uOG6kPZe5/K/soXKY8KNJm2IhZ2877hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFITpBrN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFITpBrN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1703847a12.3
        for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783893641; x=1784498441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ROlD6mdfN7+CvBywkSTjOBx4JT6mtPJE0JLh+dzz94=;
        b=cFITpBrN4oqt6wS+Z+aSoLPbPhWqczp+7BGmI12uxmm4pR+RanpI2AIUVfzsjwGqX0
         Ygj931IVx7AgL2EK5Yx0wt0dcjvTl6ZseZHRJ+NyHoRkvpSJaAIWntMexjc72yMZOIaJ
         6WzC0nb3d7q3bS18+Hb143dB6Xd1rxPYTeB/oigGVPzYFTjdCPwx2OUnO5BGJfMsP9Y5
         OjuBalcRg++/oSUu0zwo07GSaronX6RLfear5YO6Lyko7MK76z3ofFSKakN2uGlAbi0O
         OJwfm9il7CN44w307rHFq4XEYQu6QbCnluJWVgbowb0kAlr+lvtUN/BdVsfASOHYFGO8
         9vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893641; x=1784498441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ROlD6mdfN7+CvBywkSTjOBx4JT6mtPJE0JLh+dzz94=;
        b=jVt4y8I+kkzmS3XYcr/77ay+hTOROczrxy/JrS7LTnFqUPQ/I7Kmuh9hnbWroaM/6C
         /j64ZelD6VVCUj3PQBOrYHr0W/bmwe7GUcFnrJpXZcCMarh1ib6xE/AEUMagtBbIX5wk
         SvLEtP27qopQ0J9lspk/HppaLgGHlnn6L8fJETIXIlm9n4/BuJuWKAnuHTuVS0xonNFq
         1d60Nl7G70/D1h3MFaey2KJZzKCasBb5QFCxeMm2tDogwgCupZ1CwfNnNsU2tCDLvTwB
         vFq+blhnx0RLWx3EVe/N2XlugE49DEz6b74yVjMWMAEgfEgh5fZdD2rSWZq39vy2UcbF
         r/Mg==
X-Forwarded-Encrypted: i=1; AHgh+RqnkGFx2EpYyLcmwQ7bZH4dct5aEuwYss2FiMgpEcd/NFNIWlBo5P/yzaonBAI0592qnteRSKV8WJLoV0ryQfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOP6vzg4Ti9qqrl0lC+Y8/sNKF9REIv8yXKUUiO2TvcMM92YAS
	YJqkU7HI6GzKBMs/7EXmJwQAGG+ETGtVMMIXAW4/DrcFQIwVR8OYFQai
X-Gm-Gg: AfdE7cme2DqYOi2vY7b/gsdAC3sj/Z4D7afOcJ19xQFQ7lFhSVENLX0VY+ec5EtEMfP
	oABNrmeV3KyUb3saAjTS94bDSZ7ZlVRSbZGc+KBbz5J6YwY0ebVPexkbEfQqm5aojqOYFtoINu+
	AQzs91YcE5uwDB6f80Y/jv2jQGe8Coe7J3HzwzfLln0B5xAzWQMpWhlydbvdrGrb1u/V+T08lFT
	bcxu5GOV2ChUvLvdSuMAgZc9h4B807BPKoEzYTh+I4GH3pXfltOkP3c5HDTABG/DTs/u8aUwZbv
	V16CrRtXW9hXzhN4HKm61lfBqxoHLt7Qi6YHmNQTIVcXiCS0T4lLWeSomZRWqYEg73MILfDYdUd
	uxspUnkvIXueT6Q21iAdwUUSKcQRq539R+4nHfwsK6tvYMhC1FRch1AThDCUD+crdezTea0wS47
	5dy0cF4+0gmea9mH3wPna7cs3dI0D3Dj6EbxBq8T9kxQCYDqIjCONrCurFHf8orSVE16saGlybC
	mPuxKk87Ps+WjNhKNJXGWeg1UG10fcFmMeyrvHeWWBVowkDCngjhAIPFt0v4jzQKA==
X-Received: by 2002:a05:6a21:7483:b0:3bf:a0e5:99a1 with SMTP id adf61e73a8af0-3c110a1a59dmr7803427637.51.1783893641417;
        Sun, 12 Jul 2026 15:00:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm14856305eec.13.2026.07.12.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 0/2] dmaengine: idma64: descriptor allocation and length limit fixes
Date: Sun, 12 Jul 2026 15:00:37 -0700
Message-ID: <20260712220039.924958-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series cleans up the idma64 descriptor allocation and fixes a
long-standing truncation bug in idma64_prep_slave_sg().

Patch 1 replaces the open-coded two-stage allocation in
idma64_alloc_desc() with kzalloc_flex() using a flexible array member
for the hardware descriptor list, annotated with __counted_by for extra
runtime bounds checking. The now-redundant helper is removed.

Patch 2 addresses the hardware limit. The iDMA 64-bit CTL_HI BLOCK_TS
field is only 17 bits (IDMA64C_CTLH_BLOCK_TS_MASK = 0x1ffff), so when a
scatterlist entry exceeds that size the driver would silently truncate
the transfer length. Use sg_nents_for_dma() to size the descriptor ring
after splitting oversized entries, and iterate the new per-chunk loop so
each hardware descriptor stays within the field.

Rosen Penev (2):

Rosen Penev (2):
  dmaengine: idma64: use kzalloc_flex
  dmaengine: idma64: use sg_nents_for_dma to respect hardware descriptor
    length limit

v2: add second patch

 drivers/dma/idma64.c | 70 ++++++++++++++++++++------------------------
 drivers/dma/idma64.h |  7 +++--
 2 files changed, 36 insertions(+), 41 deletions(-)

Changes since v1:
- (fill in changes here)

-- 
2.55.0


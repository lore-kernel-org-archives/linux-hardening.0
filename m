Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111F163
	for <linux-hardening@vger.kernel.org>; Thu,  3 Apr 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638920; cv=none; b=kra8QPW6A6LQ5i0Kcs/9TvhKP07K+foCeRXn6CpKCUf/bsgseQdsgeoHNGCBIzdMo5hB1Vi0vpaAexizfHuWEf0yixsROJZCted3AumY3jI/W374E/gzjm9JVqAMpCdd1/8dDzlm7nVT3SWWaCIxEWH/c5+5ijTwRSc98EPZ+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638920; c=relaxed/simple;
	bh=hTAzDrPsZKafbecdYqshErtWX+i2KvAc7ypCbGygK2o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AAvHyH7TBCMu3ikF0j+J2G5d6dz75XAO3c/G9nrsYkXYI4Tc8UIqIpN27adlO2D4E8DFmlaZX55t8tCRS364pzRialx1jqvMy6HPZlYaPe6BPC4kmFEOy5Jz3EQPExHV3YTtLqxkMnYCpdDW5hdhruF8ZXSggpO/rUDD4q4vZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rA2LcBhH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rA2LcBhH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af8d8e0689eso377428a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 02 Apr 2025 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743638917; x=1744243717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5lR/rBMuVOIoUwLH4/co+le8IOHRMi1RqbQlc2/Z8Y=;
        b=rA2LcBhHshk/J3K/0DDG1sWrivwtO8jN1BdI0Xbe7lUnSSV9tmYamXFGFrr9Mcb76k
         RfNjSJIImgwgoHRcvq9Yct88cHdTVclYes9rgzhHgU+7mJtwdqYOSCzLmposHtFumDHu
         NOVsZJz/g2Bl2qfCk/voagVlJpo+iE4PliQudJCUef0igSxAYZt3lzHNLqYKYxiVYWGK
         yA7ywRZ/pAMDvTu2U7cha+JFhy8ApRU30pCn3Leind0YEwp2M82JY6XKQqun7ZRrfbpg
         RhlSBRaOWT0ltu0V06+QiB39yop5l4IuHArjuTulZTVZrK1Tq50f0grQpq84eAT8+geM
         Nbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638917; x=1744243717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5lR/rBMuVOIoUwLH4/co+le8IOHRMi1RqbQlc2/Z8Y=;
        b=mgNQbtET9gPWKWqlQnQNqqpy91b8Itc1k5AG08ZQutFaoUw3Nzl7okx7jiaIIuOaFv
         CyS7pnl2cj/veVRbMxA/YuSKH7KO9HICwRCx9W+n1MY/YtHROAl+VXepXrvJ+/Mf5dmF
         ACB9A6cYsqceJDAYj5LDAen87bfHU3oh0LPfXFJdRcT3hDeQqqbcTPcxTuGVPLYKp/ml
         HhVG8c5oGU91IDxChX34PEWHXTUN1mARU5RlmzHDeCPHApa73MVQj7yWv6LSQ31j9iCM
         bovmI33mwMxp8G5KPOi1YJgKLhkqbiMhdBUt0gjzcW+S+7gTH184UahFvqIDjhc42Mjc
         eeCA==
X-Forwarded-Encrypted: i=1; AJvYcCWz9C1YSDdMBLOpHuzmU+GvL7g+c1nJbF2E0n9FAj8THWb94rsYV8YQ2xNG5NL4VqL5ve+7QCJE2n3rFx0BNoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUUde63/viG+zIc/7fCLjv2OQKAt0gkT2ZOHBrssAl/N3ppQF
	xv8WjHiEEAJiD4FogBcKwlI2o8y1J9E8nkdui5RHOfZ2gAaR5isg4ZMcj0y84OxA6A==
X-Google-Smtp-Source: AGHT+IHuAOxtXzCgPBrdp5bAmlVDtunUBAbbk6Zek1hc3Rqn5Vy7UfRbt6b5OUG2vQgJn7Pm/udst/k=
X-Received: from pjbsi7.prod.google.com ([2002:a17:90b:5287:b0:2fc:2e92:6cf])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b50:b0:301:1bce:c258
 with SMTP id 98e67ed59e1d1-3053215e7femr21514740a91.22.1743638916776; Wed, 02
 Apr 2025 17:08:36 -0700 (PDT)
Date: Wed,  2 Apr 2025 17:06:58 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250403000703.2584581-1-pcc@google.com>
Subject: [PATCH v5 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

v5:
- add test for unreadable first byte of strscpy() source

v4:
- clarify commit message
- improve comment

v3:
- simplify test case

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.49.0.472.ge94155a9ec-goog


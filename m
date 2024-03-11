Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CE58AC0
	for <linux-hardening@vger.kernel.org>; Mon, 11 Mar 2024 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199953; cv=none; b=ROAEXaVzUiHkggy9DzsZF4Qjy1KpXwdQNdSbyqHPTuZ9FPD1Lz7q1Zo+b5rxMoQmzXLMCvgrYbHaF7eMwl4W/1Uo5sOcYPNljDBgF+j7UnpAXj7J9dliixN5CtMj6lOTNTOkCV5/ZufSdUYIX6YqgoHUQgMZ1tiXPtYjTDL7g0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199953; c=relaxed/simple;
	bh=t5pomvoQwrYYJsz4aXS3tiUT97cwLl9LUNnWMt48nQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ewaA7e3CQxSrkyyUB9MPzijedk3Y2PioB1zc7uUjF+Hscb5wECYp/Marw21auawMzDJXmc6k+wb11AxIpaXhr5QofaS4jFOMbG52tlXC39YkXvgOKLFgn3VS4+2cvtAMeVB2iBMrxtiBJBWqU/eGaYr7S/ns2vvS+ID4BFcEtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RaiNqyD8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RaiNqyD8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so3196719b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 11 Mar 2024 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710199951; x=1710804751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rocyJSHIiY7wv0/b0Thl11+2BE5Ia+FwDy18IRd8ak4=;
        b=RaiNqyD8IZXhruRJA30yzx1tDfySHiCdN0rlNMZnKwDyQSrHy9BMWNuKfIi3qZxi7+
         wvouhh2q8phnBSGZy5qPYQwvYZ4S62RK+TtneAuM+erLNe46C1neayJ3S3I6s4NxvsJV
         jw5IqsMFpL0HBjo0H2oviArFrty3r2TJLOcvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710199951; x=1710804751;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rocyJSHIiY7wv0/b0Thl11+2BE5Ia+FwDy18IRd8ak4=;
        b=mk+w6u7eLhdFXpW2Zf0DR9PFIQH+DcEcG2ZlRSu2z4dFHWsgRmLJmvFc3xP4rOaeb+
         ZpeI24rQzWJoa84Uzu0I9z6fk2JXFTIWDO8rvPezqBQ3R8rmz9HASY3poshTRr3m0yhP
         jMa0jXyr+zzWOvjrnBt50VhmTMPWo5wvA2riySSzht6F2ET3spci8oBZD3R2c1VTLHx1
         YcdIlzin3r/glt9y3EQREJcifY4Tds44oQY7Pc6oNhohRhRqpH2AGF3SGyu5FbImjsSV
         3xv4CBwUa+Qaa64rChdLIbV/oj6RDbvkC4c8AzIJiSaBR7YjZ04oBhtdsXjvR+7yn7i8
         yPng==
X-Forwarded-Encrypted: i=1; AJvYcCUgui89JFpndI3RXY4866X5ZYceLCtHNR+RmnL8dZE9uIORp/sU4N6smFnazvlwLjrdFCPKUIpis0Ai3Xn9rJJPYIvB1EWiob08tCPel1S1
X-Gm-Message-State: AOJu0YxRbBcwbZbsiYu4YVPc7c0/506WanJ1qkIDR8OGV6+qVIMeC7vQ
	odvEh/IkZzY92gh0BXbrsWC1MIF7l0n1dtwMvtAgpOvCwd4OBaDO40VFdRoKEA==
X-Google-Smtp-Source: AGHT+IFqC+a+5N9q8R+wAyOEWs64DQCVyVOI08tRng0GTb6I+DT81HbKdJ23wlNYS0YdfpAXsJo3mg==
X-Received: by 2002:a05:6a20:7d88:b0:1a1:4ded:c9d2 with SMTP id v8-20020a056a207d8800b001a14dedc9d2mr10338257pzj.41.1710199951623;
        Mon, 11 Mar 2024 16:32:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z1-20020a62d101000000b006e553cab65bsm5105634pfg.207.2024.03.11.16.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:32:31 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:32:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	David Heidelberg <david@ixit.cz>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>, Kunwu Chan <chentao@kylinos.cn>,
	linux-hardening@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [GIT PULL] pstore updates for v6.9-rc1
Message-ID: <202403111631.BB91A2422@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these handful of pstore updates for v6.9-rc1. Details below.

Thanks!

-Kees

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.9-rc1

for you to fetch changes up to c8d25d696f526a42ad8cf615dc1131c0b00c662e:

  pstore/zone: Don't clear memory twice (2024-03-09 12:33:22 -0800)

----------------------------------------------------------------
pstore updates for v6.9-rc1

- Make PSTORE_RAM available by default on arm64 (Nícolas F. R. A. Prado)

- Allow for dynamic initialization in modular build (Guilherme G. Piccoli)

- Add missing allocation failure check (Kunwu Chan)

- Avoid duplicate memory zeroing (Christophe JAILLET)

- Avoid potential double-free during pstorefs umount

----------------------------------------------------------------
Christophe JAILLET (1):
      pstore/zone: Don't clear memory twice

Guilherme G. Piccoli (1):
      efi: pstore: Allow dynamic initialization based on module parameter

Kees Cook (1):
      pstore: inode: Only d_invalidate() is needed

Kunwu Chan (1):
      pstore/zone: Add a null pointer check to the psz_kmsg_read

Nícolas F. R. A. Prado (2):
      pstore/ram: Register to module device table
      arm64: defconfig: Enable PSTORE_RAM

 arch/arm64/configs/defconfig      |  1 +
 drivers/firmware/efi/efi-pstore.c | 43 +++++++++++++++++++++++++++++++--------
 fs/pstore/inode.c                 | 10 +++------
 fs/pstore/ram.c                   |  1 +
 fs/pstore/zone.c                  |  3 ++-
 5 files changed, 42 insertions(+), 16 deletions(-)

-- 
Kees Cook

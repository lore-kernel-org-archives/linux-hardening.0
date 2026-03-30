Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97203CD8BB
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876813; cv=none; b=lgo0qkT/dHT37qZr0/+WGgyq9gSQmiwoXxBwBCR+ekRILS482ZYwqglLzK3QISwbQ2cRw7+/EbyXmUTsqFK6CpNnrDouif2/NqMIfDWKAXLS6fFJmixDb81wxj1CAWwlczyHmo5o4wb1PVyW+TSR21AkIHkXlTQZoGxEw0G9urI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876813; c=relaxed/simple;
	bh=MkGWYrzOND3HQpr7QcSWi7pVdCY/84vWFFI6W3W1PY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAmUc7ZZDxawhKxDFXAZI8ALmYLeQszR86mPCGtTZApY5DXYcLJ/i3LF4fy+6dOMopkrbpdDY1V47Xwr+YV4i9DvrZZDuLUsBrfC2TjwtI2QjBZ1LhTMIYfmlrxSH+xj2Z32ZYiXWP8ZaM/3kMDbgKR53Ao8SVtA4J0xLyK3PIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afka5U3Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afka5U3Q"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486ff201041so44461845e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774876810; x=1775481610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJwLPAT2TEXatsHbPndDKPio53vPmgRPNgk50NSzxoM=;
        b=afka5U3Q2gYQ9iLzgKSXbI8AcsgHF8Snou9HSHc3blI0W9MA1KSavXnjQMJLjBtpe0
         YYrRYU+LWWlcgP7eFtSHMdXGkuQjzboOAUn6K2ThyyP+o/L7k1Vn4wNGf5r+j3iF6a23
         U20iNcFdKbpvAjt/q2TGZRN8k/0YkK7qmUiAs/SJMP/PjqoLfUzuAJDPKxtmkWE8QdRq
         1BvCH9IP8qjxmTZrc4iH3ZzXD8Up/jSYzkjTzcGrmiFD6LUJ1BniFbtsmPVRXtME6f9y
         AxtI5pyu3y/cdSCYZT2iRLHUAoKmI+BW6ZCcCopkGCWLieeB35HdOd5vHEh3lyvI3Y4y
         c4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876810; x=1775481610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJwLPAT2TEXatsHbPndDKPio53vPmgRPNgk50NSzxoM=;
        b=fure9vxbL5s84FjgzMt/z5qB/UcQQfSZBD0sQY1JqC/wg7MYwV3eDzMYKB7PTAXaiE
         K07C2X3gAd0VeddWiT9bAXPw49PTiim8MxSQ0iIGuoVLrsEMqzKSaWy/YAFCDayMuqUk
         5NqSIHfYJ8E2L/1NdtLMlj7FmFz7yfM3//QbFaF+duk5rqpG249RO9oKolLGsgh8sfy3
         MjRHkJLw+iRaHQo+SDm7XExNHaw0fw7tAEwwX488kLVfIogCkIpnOGZp27xMC/f5XCCh
         syi6ybkdkgU36JtmqMGtcWjUjYjy03Qw1usbIhzB3AyhTH0gpVsaDi4ZaOIRBWf5TKSM
         5PDw==
X-Forwarded-Encrypted: i=1; AJvYcCVB4CvxoLG/X64dd8Jva7WGz9dw+CzsF0udiLLlW7VJikur41dwAQML/cRCiCOfovsrXUUK846TBdNHKmAHJxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YivzBuaI4jI9LlWBnWAZzpxAxC3ScS6yax3strUK+FNIizaj
	UazROcuH+29QtukxijAuvk03qLhoUy2GiENyIBYxoOA9VhLFTSY46sJ9
X-Gm-Gg: ATEYQzySIJKvs3zHL6QvHtWFDaxItgsqMIbmmukuh5JYysRjNMncIa+7KXTYgUzKzQ6
	MLesRnxT3Nxvvllyg2wCjmCTzvv/kakvwhbZAfFaisu5r4cTZc1Z+uDMxFOvYdU1AmU1WnpHpJu
	qtIppqXWNcOU+i4QunEtiZ/vBkSMSkOkdkog8+0slkpWTdFuh8y+ZCoBbjvN7CXkHog32BLE7GB
	+h5rjTJvRiz8jTweHQ8sJILpWrrOgjYmnaETDAJhSQc/GheX849KCJp6IdKeCiNgnnzRg6k1tXc
	CVTklhoIrnTR04aig6vkVdkhuM7j7BjrvXzLbwLWGfMLkW+/d7tD0am6m/3uP0aYbr6Mzm/qMLn
	7Yw3NdzXD6OQPXX5kBU9B7M8plhEWqFru+jyKbBG+yr1FT8088jGpS3hqK6mm9Cj1JxSh1HgIAa
	qDd59F6sY6Kpc1C3zQxL3cULlP9T8TF4rHhUQlVAgkoNqVCXABqpzxkgGn44V6rJygXFilQ6F2J
	kYo2C0d
X-Received: by 2002:a05:600c:c4a7:b0:485:3af5:7e53 with SMTP id 5b1f17b1804b1-48727ec3a93mr199217585e9.19.1774876809312;
        Mon, 30 Mar 2026 06:20:09 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb52e5sm81322315e9.7.2026.03.30.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:20:08 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 0/3] fortify: Minor changes to strlen() and strnlen()
Date: Mon, 30 Mar 2026 14:20:00 +0100
Message-Id: <20260330132003.3379-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Looking at the object code for strnlen() of constant strings showed that
it sometimes contained an 'impossible to reach' error message.

Simplify some bits and adjust the condition so that the compiler
optimises it away.

David Laight (3):
  fortify: replace __compiletime_lessthan() with statically_true()
  fortify: Optimise strnlen()
  fortify: Simplify strlen() logic

 include/linux/fortify-string.h | 109 +++++++++++++++++----------------
 lib/tests/fortify_kunit.c      |   8 +--
 2 files changed, 59 insertions(+), 58 deletions(-)

-- 
2.39.5


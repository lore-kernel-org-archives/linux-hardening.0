Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726181AC1
	for <linux-hardening@vger.kernel.org>; Tue,  6 Aug 2024 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980978; cv=none; b=p2yha9XYdl1JBx1omElJWmh2Pbs5+28e0KWUyX71DMFrimlVXWMaue9B8FmvdDhHQc6VoUEHPQcsfgk0nwj0KiIB8cIeeTm6xtRL387mrMGOhCsdCb/epH19XgBZv9sO8W9ZIFN/3kuwlJV4dBC2jsSXFnZvBdAs4uDJm251eZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980978; c=relaxed/simple;
	bh=AybM4sqB6S/QPEz2V/rcKyCotd4jaW03IK6nNX3w91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XT1sNK6/rUDCyfTR5wJ0O+Q2PubAN80t9n87s8MIlhFHH6BrBpcpDFXrFlektJf7QAqwr9QNaFX9EUW/1Uj3DInQ9ulPuErf3qEzWwuqJmPfi/CWH91TsDh1eaCSAWhNunG1gWodeFJEwpHzzUs1QwcoxWQcCTAHPbmJiusS0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h20FpcxD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h20FpcxD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc5296e214so10832635ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 06 Aug 2024 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722980976; x=1723585776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+tIcIGLCcXtrMQFuAghyCnh7JsC5dCfIsg6M2Zg+Ug=;
        b=h20FpcxDRUWkSl23N+Ew8+HJgLK7eCdVx3rtGDDQznw40eiDTatOdNu2vucjb76bM0
         DC0Jkgz7u+HKIz8sZDVefExSozpQUEghYaaT1XPNVNsqIl8Uz54d2fM7lkgU60mTPL9L
         PIyVY0t3i/IYdMdIIsrhwit+4brtDwzGPTbG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980976; x=1723585776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+tIcIGLCcXtrMQFuAghyCnh7JsC5dCfIsg6M2Zg+Ug=;
        b=VTkoaBqsz9ImC5KabJ4ksKaNMKgUg0YnsnQh8ZLr/TeCQVw/Thga1aIx18zZ0ZYvyk
         /H0kqlQExWGq8HY9KJnvE5nJ2n1lN0tK5+Az2Nn/tpvl3v6FTFqDL0RsMUuDw+Xvm62O
         VPdlpbBffhKkvdq7m1b01LmR9G0HRxlaV2zrujRfSqyJbC0fC1Flg78WGGqQwauYhhjW
         emzHVe8iMuevGaanucuNkroF/GZ+yw1Rqaka8ccmCb8Avkiuqgf/s2pXlLTlPYAi+cdI
         aj2xmMi0mUPkpPdAkUwVTS6OPLIDncU6QeAlaOabWTJWXOLua3DU1i8Dj5dtROhutV1O
         KNzw==
X-Forwarded-Encrypted: i=1; AJvYcCU3CGWEmZpP/VFJsMs1ULG6hFLgLQVXNUI4xps/E/zNDAhh2VaujbqJBzuiYHTiAJ6qk823k+FYrT8mtVhuV3YyoOAzFJ4GU8yQtBchX/us
X-Gm-Message-State: AOJu0YxP/tb6vHu+Sx6q1EL/e5wfmWKVNNET7F9/bFP+c1Qwkjhc1ykT
	b5COWzP9O1fA8WuXwRWq+caR5y+Fsf0VfeF5xWaGdONl/u6nlr6OOD9e+JuWH+CNGDzpG0nAb3s
	=
X-Google-Smtp-Source: AGHT+IGyIjjt8acKHrnSgbUkg5U6IiM6X7okFU45wSk883WeJscUQ1vOvzczB8Acmy52SDsQZqj6Eg==
X-Received: by 2002:a17:903:290:b0:1fc:4a88:fe53 with SMTP id d9443c01a7336-1ff57457388mr204617975ad.51.1722980976430;
        Tue, 06 Aug 2024 14:49:36 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff58f6093fsm92767575ad.114.2024.08.06.14.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 14:49:36 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	adhemerval.zanella@linaro.org,
	ojeda@kernel.org,
	adobriyan@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	linux-hardening@vger.kernel.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] binfmt_elf: seal address zero
Date: Tue,  6 Aug 2024 21:49:26 +0000
Message-ID: <20240806214931.2198172-1-jeffxu@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

In load_elf_binary as part of the execve(),  when the current
task’s personality has MMAP_PAGE_ZERO set, the kernel allocates
one page at address 0. According to the comment:

/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
    and some applications "depend" upon this behavior.
    Since we do not have the power to recompile these, we
     emulate the SVr4 behavior. Sigh. */

At one point, Linus suggested removing this [1].

Code search in debian didn't see much use of MMAP_PAGE_ZERO [2],
it exists in util and test (rr).

Sealing this is probably safe, the comment doesn’t say 
the app ever wanting to change the mapping to rwx. Sealing
also ensures that never happens.

[1] https://lore.kernel.org/lkml/CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com/
[2] https://codesearch.debian.net/search?q=MMAP_PAGE_ZERO&literal=1&perpkg=1&page=1

Jeff Xu (1):
  binfmt_elf: mseal address zero

 fs/binfmt_elf.c    |  5 +++++
 include/linux/mm.h | 10 ++++++++++
 mm/mseal.c         |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog


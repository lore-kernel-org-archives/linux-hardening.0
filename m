Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356193F9FB
	for <linux-hardening@vger.kernel.org>; Tue,  8 Oct 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361090; cv=none; b=VkYnGYkBQlQ7D46Z4WT7Bf4d69l4KHwCj3uGtbz3d3S5mHePgDoJnvmSaNZsLzra6fvGFdYdLMzjDT/rMLhw2zupE4TN2RvyAx3l4kGP05REZrYO9URWvp58BE7FAcO3ua2mrLKEPoYBhDgRNweXMgemZU6B+lwbTh6klJ0gYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361090; c=relaxed/simple;
	bh=VSZhSzhnbdu2NNszsJIrOuSYNRWmYaP3/73tTqZqx84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xt4GSRKSPfSvJk5M8z6AWm7I0RQn5RwfNS40Uc8cujMt/Hh3MLE5uSKzK7wBl3icPSrLD6g7XsFIGd5AhhBXE3eilnFlj4QNYtDZL+vNMTXCGrKZ4cHU2ZcBN284sRSy0SIKswRXy+Sgd4hks0MPExaWbC7bjGH7HmFlc8mNAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=alyBN47R; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alyBN47R"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e28b2df104so8414a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728361088; x=1728965888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVQPrureiyHbwYAfJliFzmOeqMNDULWaSzE3MpLwxE=;
        b=alyBN47RBaxB6GiJTR5sc5kqoidS0N9tcrk4Ypz1OsaKm9Q7FrBefq15hwVkzVNEiE
         LCdv8E4LhZbmIxKsnnWpGEzN2noH/SZtKzArHx/givDt6VEfcbK9fFRa18IFOXwndHVY
         /uP0XoEySMfjDnfkFmwT096TNhbJazNQCDMSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361088; x=1728965888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vVQPrureiyHbwYAfJliFzmOeqMNDULWaSzE3MpLwxE=;
        b=JAFMtSJGfSj7KFC8R9KGwJqlfwbi1t7sbTz1mY0H4EuR/JM4Aiftk9iUZCCIi3s5fc
         LzUaeSGP/e/aDc2ck939G2S98gUN2ScZRfKvv4xCgnYlOw4P9hquf32DiKCIL75dKYzK
         LMR6SO3F7JMEV4dpuv5O3GBnG9mg7cBT4lfPWlI2b7qmGDavyF1jcRUqzD3IPf6PmfvO
         KjtZrH6IT+pXSO4x6gjWUlzJJD9/zoIPqTKao+3YWD9SyRxSZq0yNvL5QUyA+YEon/Uo
         1qvwH41mqVAfLD1MfUXaJD7Kvk9y8hqMzhRZefCZxQpqU6bi2BtJn38BAgaVI07v5ZtF
         vdJA==
X-Forwarded-Encrypted: i=1; AJvYcCVNxjMLbxOcq/dLYKECQbQjI1M9/Uu27do1gP+Xdv5g0mMC0TW2efyCR8mKpMDS6SE3MWOq4bDEUHSjqVHuMmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v51cFwVKmn0+LT79TLSCsbZVWJ+OFOZdANQ7s8LpRad6cy1+
	cEQVrCLPAW7KDrPABbrTKDzwE0ffhMVFDhw65kxJafQO1Ikk2Q2cmcanhQVNpQ==
X-Google-Smtp-Source: AGHT+IETmZkdIfaU3KgL1a0e2OY78XhZ0gDO7l0Fn6ylun8F9SxSWEg+1I1jGGXk76KQfXMjITSOzA==
X-Received: by 2002:a17:903:2345:b0:20b:99cd:c27e with SMTP id d9443c01a7336-20bfe02ba29mr86787295ad.3.1728361088521;
        Mon, 07 Oct 2024 21:18:08 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e1e85da3f0sm8049197a91.30.2024.10.07.21.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:18:08 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH] mseal.rst additional fix
Date: Tue,  8 Oct 2024 04:18:04 +0000
Message-ID: <20241008041804.1481453-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008040942.1478931-2-jeffxu@chromium.org>
References: <20241008040942.1478931-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Change "overwrite" to overwrites"

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..54bbcce330ec 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -97,7 +97,7 @@ Blocked mm syscall for sealed mapping
    The first set of syscalls to block is munmap, mremap, mmap. They can
    either leave an empty space in the address space, therefore allowing
    replacement with a new mapping with new set of attributes, or can
-   overwrite the existing mapping with another mapping.
+   overwrites the existing mapping with another mapping.
 
    mprotect and pkey_mprotect are blocked because they changes the
    protection bits (RWX) of the mapping.
-- 
2.47.0.rc0.187.ge670bccf7e-goog


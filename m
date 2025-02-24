Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A617026656E
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419125; cv=none; b=V3ZeQndnsXQoDvJtUuIIvlHdr9+63381ZrL6i6onD6l2sh227MhdYzP6Gaa2ufbrXL+wh60U4RLOdzThgkbNOKpuobrnC/B9WsZDSqPKRnzEQEiBeXVIkpgNGlP8+3/eQXZ48rAgZ9QPibU/uVkoZIyxcDYwbQyWoGscPm0Z0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419125; c=relaxed/simple;
	bh=1BOlD3CY7Q7i+Oz86sDe82UKyhlevhIg+0IIHAWWAOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEy3PQBrcZUBtPeV69uZ+tNNHtwhxZGa93kUU+ErB2Ynn8xgaMjQhG4tyADQFpwFmmtPDbkRgosFU1hkdTKf8Xs4dZ0O0gEptw5tIYVVTXORM1Y/BugV5T6/afqmBgLiukeuF+wclib+bhI/M7QQHiEjT+6cFoQi3Emu5Ocq1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rseh1RhV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rseh1RhV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22134a64d8cso11339815ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419123; x=1741023923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NedlQ833R+dfasjp2xtVkBoypa1M9tQutc1AiNG511A=;
        b=Rseh1RhVrbWeM2VulixoeyKqs9Qj49KooO2MR9jLWT03wzMGYNUsJUm2SoH6a5vCxY
         A6uJfT+81yL5v20/BLjyROgzUGW3SiB6pJnqpDH4gXD0UDzdkmiPcUz2eglNmAU0qfOq
         wa0Q2rbElFdCHaN7l785aOqpbiJrKkdHwzquE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419123; x=1741023923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NedlQ833R+dfasjp2xtVkBoypa1M9tQutc1AiNG511A=;
        b=cIFnyoojJ4l3YorHHwsHtQEOLHqMybnzpiVjzjjm68w2YRjG6n7kEmxg0qgKP1J9zg
         kW6laMFPO6D2+TeolmkwXf8HabgEYnY6Mw8nHYQT84jWGWeXPoLtDe8gJBYu29/9oYRt
         XHPd6ozAcB4W87XMZi7i/Gkz8gBaLxcS7btw5HpX7pEAxdjMUNi6TVMM9ouOvXGPMnbB
         B9RI4jXBAnjrR3bFceoiB+cIgmDJDIV80xRjvl6z/f81Kc+Yz0oRZE/tf7QShLdDDPSZ
         QOW7ZJCoZORbL5GhxwenmovdYERIackRBdgRSq3WhJuF5zm+ZiZ9RKTAZs0CAVKeHHjM
         mKEw==
X-Forwarded-Encrypted: i=1; AJvYcCXiZt8zXrBCPVHmcx1JS1Mg/uxl9pRixllp6iTUajuNmlZegTxfTIjjtaE8QYU6jJcUqnS08um93OIsxT+lPSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZ7Tgarflr+m6GIUhoCBXhgVINHqbDyVH9/AoE+8DgMUDgVox
	KtKRYGkSawCsKqWFdPqdeS6Cu0G9nJuJacdlWJI8ck1UgwrFIQ1r4C5jCXnUHg==
X-Gm-Gg: ASbGnctwz5gqqkbnp28sJzCabqu+uzwJzWnTBmdSpq+DWeKPHMceAKnBnGpbMSXHLIQ
	lE10kT3uke3myYSTmJqmXNNm7qD8sZn3mbfIJIjk8gLtCzFdyWSYMundKev9KGbjwMGpp6q9XbI
	E4QKRUyQQGU/dQGSsMt79Z3WYGqExApJk7qBjtKYzbLKMDuoIPfDiomr+XJ+YHzt8nstkU6AcIL
	EQdOT5MOFyf69z0U3F7t0lVBdIL3U5g2sbWz8/p4d8VJ1KbsRaJSSKtUh+VlkgDzYtGeWx1mTrB
	IhL9xzZGSuuAWdAZnmjG00kbVMQpA4tuzxFUVYj3SmSpeZvErZ61V86fRrIm
X-Google-Smtp-Source: AGHT+IFZVTqhLnFv9AH6bcykjpAlvnpYSGZUQrdwYTW7+qFqbmLc8OL95CLeT9nCPZhlXuZDXrrHjg==
X-Received: by 2002:a17:902:d488:b0:220:e98e:4f17 with SMTP id d9443c01a7336-2219ff39595mr87888225ad.2.1740419122867;
        Mon, 24 Feb 2025 09:45:22 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb093d96sm6756326a91.40.2025.02.24.09.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:22 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Date: Mon, 24 Feb 2025 17:45:13 +0000
Message-ID: <20250224174513.3600914-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..10147281bf2d 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,13 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
+  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
+  known to relocate or unmap system mapping, therefore this config can't be
+  enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.601.g30ceb7b040-goog


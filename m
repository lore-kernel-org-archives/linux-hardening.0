Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B034CF5
	for <linux-hardening@vger.kernel.org>; Tue,  8 Oct 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360588; cv=none; b=UMcDiNLS63HfDI07DgacQ0rmqntYeu2qHwcQm8IgRTDVLnNIcM58zHR2RIyJbMC1QXMONsjdnjNSSc4hCE4m0s07OmB3KK5TvMvVy+MFKFxp3irQ9iJVBHjweU0i0MXgjb2J9lt9Dj6P/4dEbJF2Isxq3bos55h8iKIArNLnJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360588; c=relaxed/simple;
	bh=CpYT2bjDDZ8HeA0Wb6hywG3ciBJ1GbJbSGD3iK0OK5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiQ1kb0dGqhCOl5ZFqWNA3jmglrYNpWKeZvXlTzl0yFFhJu6iLAPoN1U9IT3kzd+6Xu23jLX3bJQ5NAlvtv3vu6rbUgHZbvtjLieALejmReoK2NWI8wDwnhouBv9imEvfdIo9AbnyLoUPiwLxdD+AeIgiJJZHULfRAd8MbAIjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CEZeQsWM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CEZeQsWM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b067fcd87so4093335ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 21:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728360586; x=1728965386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ZGUL7jMwMvNfJbHmiytAX9Q9GIqYELEwcb1y0M4+A=;
        b=CEZeQsWMG6YYP2FjucGABSFYmtxCEL+fna8y31H4T5cTOpYokNgCZh4NnJeyKYzcx0
         /CEPjt9aaYu5cALiMhKRMZ9SJZDEKBOek1BXDFCXUfT6lZb/CPFPJTKcYLRFYaBhcmQ1
         xipBTXoUp3KuJpTXVZKEFiWABUk1MHHBOrwek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360586; x=1728965386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6ZGUL7jMwMvNfJbHmiytAX9Q9GIqYELEwcb1y0M4+A=;
        b=AyJ7ZFD/7nvqPAT0qRUcxBoPETANuqxudLIAY3Aluq4HfLzupU53bV/COwPVe95MwT
         nbivz9Se7j7zegtLtjj3z9P7b+zLQnPOUYJeQHWhbSSZWK4W7+RCXQEHN8EECsHIw/Jq
         M70inPBMrpqYR7syc9fcWvu00SpL3M85GnNNPTvs68/Q9zo5EFeRYL5ks8Ma7KdZ/xEP
         ByFd9Ut0SPu7QkD+yoF9vVt6204ecrvSX3nDa5iemIGq74CTkK+wmLqelLrjzDRMJcU+
         8FNoX8hHvTLIMJrYvXJcxxTS/6d1d4LrrZKZ45jzMKDh6WvhTH7q67shT98nrJ4ZaKMQ
         e4yw==
X-Forwarded-Encrypted: i=1; AJvYcCXqeidqr9iD1SpjzXtzx+nYxZgOfNOv8CRwXtCBl7D2Y+66d+CeMV7YQtsglX1ImPbchaM3drIIfP229WAvjXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7deYlhe3asjm8gIpS8quSna+bpAo3H9xUcrHk6dkXWNNJp3BJ
	TLaBR6A+j23aMyshlO+z/j2gzvkHe+PVpn9w7LHIhMSIDOvQ4MhErfzlLWQNPw==
X-Google-Smtp-Source: AGHT+IH3Tzn6KlmwwEjDW6lynG5u+Vt1tkuQKry5GB3eE3XfLVQF+SrNLkDuseDanp8wOy58Zy4SaA==
X-Received: by 2002:a17:902:ec8f:b0:20b:5699:178 with SMTP id d9443c01a7336-20bfe04bdd1mr89735445ad.5.1728360586544;
        Mon, 07 Oct 2024 21:09:46 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c138d4fdasm47234075ad.118.2024.10.07.21.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:09:46 -0700 (PDT)
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
Subject: [PATCH v3 0/1] update mseal.rst
Date: Tue,  8 Oct 2024 04:09:40 +0000
Message-ID: <20241008040942.1478931-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Pedro Falcato's optimization [1] for checking sealed VMAs, which replaces
the can_modify_mm() function with an in-loop check, necessitates an update
to the mseal.rst documentation to reflect this change.

Furthermore, the document has received offline comments regarding the code
sample and suggestions for sentence clarification to enhance reader
comprehension.

[1] https://lore.kernel.org/linux-mm/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

History:
V3: update according to Randy Dunlap's comment

V2: update according to Randy Dunlap's comments.
https://lore.kernel.org/all/20241001002628.2239032-1-jeffxu@chromium.org/

V1: initial version
https://lore.kernel.org/all/20240927185211.729207-1-jeffxu@chromium.org/


Jeff Xu (1):
  mseal: update mseal.rst

 Documentation/userspace-api/mseal.rst | 307 +++++++++++++-------------
 1 file changed, 148 insertions(+), 159 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


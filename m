Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3608205E3C
	for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334094; cv=none; b=PG12oGcFDExE2lj9YiemPirwLGRstvws2GJ+bFtC4HNPIY3vF//23a2E+lBIu2jgEnylRThjBzLAE8kmkKfKm0B1HGuBCz/OcIALpfeUG4v8tB5c15D8bcF2y5LoaDYdcdF/5WbEASLtX1CHCz9h8PnJ2eMvd+rl46FL1h5aA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334094; c=relaxed/simple;
	bh=ikVSyIcDjEAbw/xIoxMzWfbS6Uydb28wDt5nD4ZIUd4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sIpRTmYm5s+CvGKdesiNjtu5bvWDddL3hkVsUXZCxWW5jLo7oN/HrMdfwe0sVooH+jrOyoKtQDsvOiJEJlCTPBy1oXl11eO3BZkhjkgCk+gNZXVCbYUbgWgvBjGMtfAm6lzHl4ItJ2gr0yfZXzHs2IdZsa2HOOhbIZQAKBXdu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4frTxwpf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4frTxwpf"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso10143788a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334091; x=1742938891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UnIVkMBpPNHpHkzRiOFkBTXk7lARMRWDLlaFgNuX0xs=;
        b=4frTxwpfBkUdDd66o6UISQEQ7LC0N+ECOF8tYiqW7ZhsJmJdRuyBePeLQfGa8IUNPe
         d3GUlCExrNbMOXV7UR5uOlDsp8HZdNAxm6AWJhMwBJuem50E2dZNjDV8mGEzjNkncsLV
         xULCUjBmysEA/zNPz4jWLePtZHURg4Z5I3GrYiQeQdoFDXVhVe9B7O4JvqIFqQ3ZU0RW
         7Ac/pjVEypZT3M9NHfQXg8qh4HisZxYlxCElSexetCwNaNEufiomoKPXh/zWTg/l/4SY
         h2nSjeNdcy7q1Gm5SGtbtjKMTgDbqWsKALObr3NeGY/klWbq8JjNiXG47Hege4oHBuUC
         0Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334091; x=1742938891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnIVkMBpPNHpHkzRiOFkBTXk7lARMRWDLlaFgNuX0xs=;
        b=e45gJvJrBa0GiN6fC0+ZdXkD95P9+FC7r+0DyBEObrexx0gImwSynVgXrxomzr10lO
         UQx6y12mDY1BWKEOP0QnKQoD4dEmfLnG/cjnWjVionvRQT920+nn1vIoeVYMYtY2Rujm
         k7noDeB9865fhuwRvm92StOA7EFLStt7ij4ItXs2jxMnng9R2M+eoV7QLlaQ4/JQdr/U
         gtFLZGgsaQL/r5f2vYKiQ5P8mT6eHTqdyJtutPo+LMKaKY5P9EL3Qql2P/wbzDiI3gor
         ROhtBRmcobfmNSHGKTsTtioY747IJ3lFQ+uKDb6o5jhgYPKWveyo1Ui1ZBsfJo0Q4cGX
         qV5A==
X-Forwarded-Encrypted: i=1; AJvYcCXhJqNh2MvpX9ZfTBIFzsVBTLKuz5cVevrsZ1GtY2Z0xhwLuhAtR9B/iH3xQnFFT0pQa5ppXImdWISzMMVqEbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeXqdRvsEpr/NT9TxEfp6etdgPoOnUg2LUCfdlsoOKEnT+3Y6
	tQjI6mrR4MWFiBwVb3E/GjkKXLfWbJ6MJ+C+vFPacVaGQPCONCqpZmHdK+VbNh+XEg==
X-Google-Smtp-Source: AGHT+IH5g0RwWRqxELrdXfaTvTVYsLQLg1QItq6jladHXzNeggEyGQsVp5rE0/DCSbV4ptgpJfGrPOk=
X-Received: from pjbsc2.prod.google.com ([2002:a17:90b:5102:b0:2ff:611c:bae8])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4b:b0:2f6:be57:49d2
 with SMTP id 98e67ed59e1d1-301bdf714e4mr366009a91.17.1742334091291; Tue, 18
 Mar 2025 14:41:31 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318214035.481950-1-pcc@google.com>
Subject: [PATCH v2 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
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

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


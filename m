Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09625382
	for <linux-hardening@vger.kernel.org>; Sat, 29 Mar 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206631; cv=none; b=UgxzARltc/Nkg4wF44R8/n2INOy2RVC8yt4N53oCJHH2KDkXzzRw2WLJxMdmkZflTGLCenhUkvteFsSzqJiyrg6Y2B5IKBnC+CqJ0FMeoYY5M6ZqU9MmutgoXvWoZJy5tJys1CZWw6s6Q7lqG91TG7IZrwwSDgITI9Mwzf+5WZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206631; c=relaxed/simple;
	bh=fIVZQd3GTQn8c3H2yxUcuv35aYVzYmUAczMT90tM7+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KFRda70Xa8F1RT6UR54R0U/FhKiVKJQ48UKZVmwPPBXslyC7a+L2asu20UJQlqP/V4+CDZcrNKkUdHMsHWjkschW4INRcbNyuqlx8g53uOE6CoB26rxkoLUuQsTPYaOzHT5Fvj0WLH9w6O1M32muRsdHlYjx9FgDcawqBD3Cv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUNvFFRD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUNvFFRD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so2838136a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 17:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743206629; x=1743811429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T16tHjdcydDyfcQnO+rO78FihM7DOnKeDErtF6szV0c=;
        b=pUNvFFRDxksRW1HMD47izGIosTI8awE7rlxPaEbJo6dN8bhIhPQLG6Ww5U1YOJSAwr
         JYST1KWiqcggcTtpE9MKIIYoIj0eoFg+Gv4zce0axjS6WHX/FDJ4E93W9uQhv2JUYowa
         0NVMjfpUSLP1q9KjGJ8KVRbzlq6NqTdeKIdX6KnVTKBvC0xn+ZCA5D7ru5UFNdkX22HW
         CHTUHkAyM2t/c9JVzVYsOC+QshYzRNgsxfKLKmYwzWtDC1YVLT6cHMyOUS2kNSKzkO99
         1Jkryt/Z17QC/ZdqAA+60oJvVDzz0uBaGsHvCThmm/fi5XBDfxA7ibt2LSyBQVYIZOFE
         jRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206629; x=1743811429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T16tHjdcydDyfcQnO+rO78FihM7DOnKeDErtF6szV0c=;
        b=o1JsmBAFRAO8QJgfW8rZPIaDAUGmFpfLpZiqKu46DUg83+BztNf+bx/g3DIXQ5MJ35
         vy5fzwc6/TXuCvyQnbR/2/YVKoDsAYzksMUYXCpzu0sAKvOVMiYcEqCC9jvFW7By42rB
         EQI2wEG7SilRtWH7AZ2kRKPmkLJ3is3WMCuhs6LzWTQzwZnRB5cugfgYfsHFnHjuVcTa
         meClvSinbkom3EKz0I9X8pD0b6a0RSoHBuE76SVeBcp9APqRJpLChn3CVlndNMOKb/+6
         S1W6kzDb6XT82V3g2E8QcGctbXNsaKdAImashHThiZ75QVRSKOKI2KILISazvSppPt/X
         gHSg==
X-Forwarded-Encrypted: i=1; AJvYcCXTG5JaS9pkTK8XfgQMplWFKV1tqZCvGyFDj3n6m/UN7jRPGuZKJlo1MmNzhxdXu7Q5hUIYmxClksi9RHBf4To=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwDWLThgqAGg9i9HeYzsSHMnBXjkAjPJsq/VInL05opZY0ySD
	ZVd5f8wyezy6BArdzjRHlIZCkg5E6ZyjEwEGY0FOWclj+v69vVRjhDA9enUe71gMmw==
X-Google-Smtp-Source: AGHT+IFXbp95YRShZyWDHTfWt39VhfR88gtKILTuI2qmMg5tUTqt0nYA/ekMozYHGJNsTbYe2UjU9BY=
X-Received: from pgac16.prod.google.com ([2002:a05:6a02:2950:b0:af2:37c4:2ad])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9e4a:b0:1f5:862b:a583
 with SMTP id adf61e73a8af0-2009f78553bmr2229842637.34.1743206629156; Fri, 28
 Mar 2025 17:03:49 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:03:35 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250329000338.1031289-1-pcc@google.com>
Subject: [PATCH v4 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
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
 mm/kasan/kasan_test_c.c | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.49.0.472.ge94155a9ec-goog


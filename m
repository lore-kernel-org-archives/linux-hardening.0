Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B873FE64A
	for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692538; cv=none; b=GaB6wuu3hjo8TdUxbyiLV0IRri+uSwftaahJ2fYq5VTAprnqNAw4sFvOFnlR4b/Qdi6yY8p6g5LSsspIFeKwoa9v+5tfO0QNmIqkZmFfc17K0uv8HXEf2XD4w1KuCY2o/q78wCeBeQCnpLKR5TYbJ7ooAq9kwRPei11ky5NpJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692538; c=relaxed/simple;
	bh=F+1IYpyjzpe9iHTEepszy6yA5dLdKR2QVmSm5rQcmNk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JSIsmZMOl1bVKQZbuRcLZWOqfASED6WyNH5BtqWIX9a7auRmPGVhnQ2qzvn4clI6AWyXwnGSxDB8BHvoFFYYC0HXJi9+Q49ltVIloKciaoO3uF7NimpnwfNiwq11/vYJTxwYSiXxjqFaHtTG7IZNlEHzldNKVsJpM25HRN3pSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mariianikitash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JBwPI6qB; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mariianikitash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBwPI6qB"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so1559679a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786692529; x=1787297329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M14hGkxKzgTjrw+Sf+MeT5uqCNc52Rdu5nt3iXHsVtU=;
        b=JBwPI6qB9//IEeWon2XqnkIg+wmd32sn+e6dktQIrJX/pP4p0ltEZz4kvZgEEDTx5q
         jKBtj+g0Y76q6NyaC2mArIFPB9onbCddk/2LoqTl/XIXA/8NeHKG6FJ8KDbj3h4uHQc8
         Rstt5UJNCwu7MRN42vnp8RK5ecVallPzeoZ6GzcByoymAQ8TQ/NpAFwHi6LXNtYMtfot
         YY/kNp0CgphdUeRi5IQegznxCH81jwVZ+sO+0AslGQa+SshJ3FhYXmX6jeM3VJ0U7In6
         0LXzrmhDBN53fJA4RzAPvLlZ3Q9SACsr/3u6U5kQ1i8JFEbWq9r9nI+1nVNc8M3m/n2Q
         H2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692529; x=1787297329;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M14hGkxKzgTjrw+Sf+MeT5uqCNc52Rdu5nt3iXHsVtU=;
        b=QoOfPrYoamc+pDGRTGqPXdkud+RT10p5UYjsO2YwDppwzGFsOF7HKtqo1a052DJjcC
         s+bRu+/74R09yJyxUfaOaDnhvYzPpjjXPxAbzTstPxEnHEVAA32PsEuZIqZ7/eG5E282
         45j3Xs5DLDYrIny6XDALFAIMMRjJwSg/Z4yZPd3AmaZwGBmTYKPkdbHNBZRYTryTEzOC
         2+6yr1FXT1ZBGji/iRCPYB0zAMvx+GMVo+3dS8LHrWgpO2FtINnqo+Jn+0Cx2BiX3rbo
         ExzyKwDcrOJPrLxPlp7p7L7GqXnq6ZzL4O/yFxWWK0B35Zd7gEfp4b7JpAuz7LHroyIk
         KWzg==
X-Forwarded-Encrypted: i=1; AHgh+RrGOlA9tNUBD6pCbU8JOMKR2i4/dbDdHqzMz01PeQqzJJ/0oTx9N6zJl5G5ztCQeGhxnCjCu2vP4s08kkbGfAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKySXhbjCB6+k0/ZV9FSjGukPkG77mxJfVK0OG9k03uvSztiz8
	25pQQx2RHo962CMX+xPpdcPDKQOtmJeeKhlX0XHC9Tbzm47aEJVLonSnQs4qbnuia2cWie1/b8I
	pABcrte55WkMERvUVRsi+qnRZbanne7+/RsDKVw==
X-Received: from dyco25.prod.google.com ([2002:a05:7300:51d9:b0:30e:953c:b434])
 (user=mariianikitash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:48ce:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-3933b6d05c3mr4722707a91.4.1786692529154;
 Fri, 14 Aug 2026 00:28:49 -0700 (PDT)
Date: Fri, 14 Aug 2026 00:28:45 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com>
Subject: [PATCH] NFS: nfsroot: replace strlcat() with snprintf()
From: Mariia Nikitash <mariianikitash@google.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: keescook@google.com, justinstitt@google.com, 
	linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nikitash.mariiaw@gmail.com, 
	Mariia Nikitash <mariianikitash@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for removing the deprecated strlcat() API[1], replace its
uses in root_nfs_cat() with snprintf().

Build the separator and source string in a single call using the
remaining space in the destination buffer. snprintf() returns the length
it would have written excluding the terminating NUL, so comparing the
return value against the remaining buffer space preserves the existing
truncation check.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <mariianikitash@google.com>
---
 fs/nfs/nfsroot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 432612d22437..e951fe731679 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -173,12 +173,12 @@ static int __init root_nfs_cat(char *dest, const char *src,
 			       const size_t destlen)
 {
 	size_t len = strlen(dest);
+	size_t remaining = destlen - len;
+	const char *sep = "";
 
 	if (len && dest[len - 1] != ',')
-		if (strlcat(dest, ",", destlen) >= destlen)
-			return -1;
-
-	if (strlcat(dest, src, destlen) >= destlen)
+		sep = ",";
+	if (snprintf(dest + len, remaining, "%s%s", sep, src) >= remaining)
 		return -1;
 	return 0;
 }
-- 
2.55.0.679.g6767b8d81c-goog


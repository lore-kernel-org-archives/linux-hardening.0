Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DF8827
	for <linux-hardening@vger.kernel.org>; Thu,  8 Aug 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153452; cv=none; b=PRQo9PX81oKD8yJwcmGqMoz7g31ptEUnX9A/ZEDppTCyOYaJqLyOAU2W3Ou0KzGttvJWKiv/2z/mKT9Dumkbx+h43KbQeCV4OHawDdR33ezzx6ACr/+IN0FLekvE1DNqmQRfCUOu/68oY/8kwdWnAIZyW4Qtvi9usHHjtJ5O+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153452; c=relaxed/simple;
	bh=gxZheRPRrh0ESECFeMYMWfhiCS2H8NmXceOXJ90cmdk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tOtCcNEq6pErjOoZukD/Xkvu7PgENo2PRoVA/T8wPkj+Yqcqq3Owc7TK+B78APfMTye/Z8cqUMvqVqbIzB1Y0hC5AF+DiFX4+Wtgq7KfPnKTFAS0ejaMireSB0Hm63B4uoZfSv7PPbmmjhBMdC/9S3MNNbT3HxkF0UTgLfI2lIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veVldDh7; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veVldDh7"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-81f99189f5fso189349039f.3
        for <linux-hardening@vger.kernel.org>; Thu, 08 Aug 2024 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723153450; x=1723758250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7Njvjn9oRxG1GcC3Y5CHsJ6/2bwp5SyQupI3WOIPZ8=;
        b=veVldDh7E6wjklcJ+ZzE74q8U8iS76l4WAcWm4yyLuI7oLMJZhuroO5dKPkJgfXEfU
         B8u+2iF/+cLpmsVk3JFr/dbifyoXIPZWwuAcNhfF7U91mSZ3NeuCS73JinkaZq3QI0Gj
         qKFnry5f+zDclohAfaAMzRKoRODCmgx0P8vPbIyEIt1C+dxC9YpdeeaXFg7I1b9QjrtC
         2sxDqx3hrcDdbIGx34u99lQTZYpZ97Fa0WJI2mjupkXDRV/TczETUWTDz45KE16+mDRX
         JjB1NK4v0tB6DnoozJxWbsSLQQj4LfkrplqOSGZlfyG850kw0Y3CS6509uQwld0xowXL
         PVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723153450; x=1723758250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7Njvjn9oRxG1GcC3Y5CHsJ6/2bwp5SyQupI3WOIPZ8=;
        b=Qe51+B7eZKmZyNbuwNEODp5LUrF/XJA/ovPPkY7WXgy4pqgztzBtpWKXipT8vWDmOk
         5g7lnmnZEcQIBjpxEpvQd5qL/Jy4AnmWoAqdwGFDUCRQFrR8d54BxcN1jh5mUmqPjNl9
         eTuTny75beMbQJiaept5qcpt6af+SoR9ahvyJvwbYeyIsQ+CSUQ10K6GxgnirL2+3ZoG
         slrBsVFj6gcSFXxOanAuDHS0o60O9XlwwcQpiCYFmARZnIjN/2Sb7M9w64NDJEOhLSFl
         teWxLXDVpDZTHFGNAJeOXyDhOgbDemKY68rB6Bl7E3UMikZNRqfnvgua51Y4cMY7XecN
         b3mg==
X-Forwarded-Encrypted: i=1; AJvYcCWrabqRCK5qPyTDPqEWan2fON2FgSd/6AlJYp5IshntfHeibiakQ5To9WVzqABl7fnoFD9XLq6JOl6v2JGwtXZJH4LUtOM9FAOorlAR52B7
X-Gm-Message-State: AOJu0YyxbTFe6m6HELXOHRK0gHd1E2WfNoDmFWcYJKkJnt624N2+bSkp
	UVLZJACvF6/fWThVexjiaHGWgp9e773SFaU4If8hM/evLHKZQKgcXeK3RMgFy6BpJZUF4cBn0Bp
	6ucJH1VxGktAHwn0YfFyM0Q==
X-Google-Smtp-Source: AGHT+IF2a8Zre2erAGj+IY2Rz+ww39OEjjAjKfTInajDc7jmBkvGOWMbMVzJrEW2wguodarpq9y9aYqRFpIjN99QlA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:13c6:b0:4b9:13c9:b0fb with
 SMTP id 8926c6da1cb9f-4ca5e168ae6mr115896173.5.1723153450039; Thu, 08 Aug
 2024 14:44:10 -0700 (PDT)
Date: Thu, 08 Aug 2024 14:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABs8tWYC/x3MQQqEMBAF0atIrw0kRiF4FRHJ6I82DFG6RQTx7
 hNm+RZVDymEodRXDwkuVt5zgasrmreYVxheiqmxTWuDDebTGj2F8zpt+B4QneYYnfem80hpQei iC1TyQ5D4/q+H8X1/722fjmoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723153449; l=1011;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gxZheRPRrh0ESECFeMYMWfhiCS2H8NmXceOXJ90cmdk=; b=hyAQlfFdfvOunuuVhFuSBzX4K/fn1CuECQL5QSCvdkWTWpSDJmPoiuf5VOPodkWXHmavqgfW5
 6k/PA9MXaARAeV7vIXl7JCSTxUP9N9x6p+pLQBKHEBygNH63PJaZ+3H
X-Mailer: b4 0.12.3
Message-ID: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
Subject: [PATCH] lib/string_helpers: rework overflow-dependent code
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

When @size is 0, the desired behavior is to allow unlimited bytes to be
parsed. Currently, this relies on some intentional arithmetic overflow
where --size gives us SIZE_MAX when size is 0.

Explicitly spell out the desired behavior without relying on intentional
overflow/underflow.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 lib/string_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 69ba49b853c7..4f887aa62fa0 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -321,6 +321,9 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 {
 	char *out = dst;
 
+	if (!size)
+		size = SIZE_MAX;
+
 	while (*src && --size) {
 		if (src[0] == '\\' && src[1] != '\0' && size > 1) {
 			src++;

---
base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
change-id: 20240808-b4-string_helpers_caa133-53effde85a18

Best regards,
--
Justin Stitt <justinstitt@google.com>


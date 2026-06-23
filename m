Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71131B130
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233307; cv=none; b=ANYTmA02Y2z0CbNYeuJVgTebttznVphlHzpEf2Op3Q/XvGrAfjS4CYKk/VhlYjkiU0Yqp1axpWFMw1Ly/3YHiT1FM1Igk+Zob7okTNUK01C7oURYf1Srn0CGpbb9cQriGI63qCTTOyEf3X5WUuKtUBAWpiADjz73h4uS6k1rW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233307; c=relaxed/simple;
	bh=5W9/ysumqOx/C+0z46WnNJc2ZT8vCEWjgUPP9cz3mcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq+FqkQVIyg7sf5LQzs8M4mr9x2ycakbNI+Vzg91FWNFJbYWtO9HDnKlBpTgncQYy8692/+C/xHZ4K9kZESrrUgPepNlE8Z/e2y9DDxOTPXFgYHBPQLNu6xli2pwMtKd6dllsPMBH3Um2QtRQdtNy8ZVfQ6sFrdvQs+9JaIxjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLft5KCT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLft5KCT"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84232e83ca9so76418b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782233305; x=1782838105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuCsDRN0XC49lSZ5pSlY0k50HNKNpHDnltXtgvvLnGA=;
        b=BLft5KCTw0/hChM9fZkA1zNKMSEoaesq6UtK6XR+rZET67uWoV+GYbWngnyM3YcVlX
         irazIHpvZlGz6XHV7rqYc7dj1EwSQqlwFMcNEVwUBc0r68l07TaWrLsuEy+eVrmUsiDc
         4sH6HbgTXgH5gMxced3PzVOWu55l3Fo2oQQyanuyENRuRWGKuC06/HANJjw9ecQeSoX5
         PJYJQodKi3psSAJpdmwlc1ieC2hGIMiiMwUrgoNX7X2drUmG3Gp89XMSk1e2ogS8mSil
         oZBepW8anXLXYYACKBn63K5ZdEs/AjcMgiNfcCymnIf1bEcOLZyhph3tXWva4uy6TNFm
         nr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233305; x=1782838105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuCsDRN0XC49lSZ5pSlY0k50HNKNpHDnltXtgvvLnGA=;
        b=Ebm6dVx1Uy85Ve+ejBgAFr75M3uLfEas2AFLIWmcRRIUeCMZQtZ+c5SoP/PEBkOb3U
         vY86l5FEu+7X7S/LLbRk5y52XCSUWFPfDSegYOjK7M37jAMXclSfdVqiySpH3Ync23hM
         YXhntwGsyKYW2P0Abhw+5rMK+l3IYobGeiGfTvfsSlM4ol5zjApWW7ZF10caVinxwdc6
         aEYuzLPcBXXqyQtxtCN9vMMksz6N5JQyD0aiShHsjPkPV/6+8O0KXURZTgkE6xWLgA1m
         D85sCD8BqAWI6b/nQ4hMyiOYFSd5hTyRYQ22SLiZJIUe+smaBoVPS4qlf8adAXW6uuN3
         4QyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3c+IfU/4HHI3eKRrUXCTGCCdFfnS9/r25JeT1Qe7VxMuUNl9QV1j9LC8Pf2IhXrsVJ48GTkote32rzcP6g5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsI2d5W4LL9tpYVdz1NF6OlS7qAhvSE7qNfBzrgmhw6Le1a2pX
	ALQkwi+mG+9l/U7Zq+hc49+vRMVt/Uvizk90KZVcJKHfZ5Dj4XupRZeM
X-Gm-Gg: AfdE7ckzaVPd+4R6ZJHnSKarU1oc+fanaOA3XDJ1YvN2NlwOkl1uklq4KcZMulUzNiL
	IdJ8eovpsOl4/TBvERnsM9e02SVGIGWtAmIT8P7G+ffb6+7jEUcGLzVZi5rcXsa2950NBhSp1+M
	evHgREBgO3yTR7w14/b4BdTUJlFyYYVF2C4KY/JhWtt8dOrRWbVrLmAN/Th4GkQwrcAnfnZJ03S
	W4mymQAcOItskPtkdfuWd9gKtEvxutgHgJnhsgqyJA12gtC0707KNMO7MUjsGHweTKXhgvZEUBT
	KaJugN4VwpCj0e0MU6WUSRUS1QxCMD6KTSq3FjekR6xNkMiLqVwgeEm9JgYy+kWjn5UxVGbOZSP
	hAbayY+vLxKC8bgFHj78ZuDFpeYn4mA4zlunIfL7pIo0NgAFpqepTuQNruJZP7y0qoY3a/FMO27
	dZuhiROz1DZT4bx68sdtQHtCZKMr5FWIhkYPEh0owuKGCEfA==
X-Received: by 2002:a05:6a00:4616:b0:842:7992:bdc5 with SMTP id d2e1a72fcca58-8459544013fmr4670334b3a.41.1782233305513;
        Tue, 23 Jun 2026 09:48:25 -0700 (PDT)
Received: from Athena ([58.146.97.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecd779sm11373382b3a.53.2026.06.23.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:48:25 -0700 (PDT)
From: Harshal Chavan <harshal24.chavan@gmail.com>
To: krisman@suse.de
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	gustavoars@kernel.org,
	harshal24.chavan@gmail.com,
	io-uring@vger.kernel.org,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Tue, 23 Jun 2026 22:18:01 +0530
Message-ID: <20260623164801.5680-1-harshal24.chavan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <871pdyxrxw.fsf@mailhost.krisman.be>
References: <871pdyxrxw.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gabriel Krisman Bertazi @ 2026-06-22 20:04 UTC writes:

>Hello,
>
>Do you have the liburing side and test cases?
>
>A few comments inline.

Hello, 
Yes I will update the liburing side with helper function 
and add appropriate test cases.

>> +	/* clone file descriptors from another ring*/
>                                                ^ spacing

Fixed in v5

>> +	if (ctx->user != src_ctx->user || ctx->mm_account != src_ctx->mm_account)
>> +		return -EINVAL;
>
>I don't think it makes sense to check ->user here.  But is mm_account
>necessary either?  How could you get the src_ctx from another process?

Yes, Keeping this check would unnecessarily break valid use case like
Root user passing FDs to guest user

Removed it completely in v5, thanks for catching this!.


>> +	registered_src = (clone_arg.flags & IORING_REGISTER_SRC_REGISTERED) != 0;
>
>This is better written as
>
>registered_src = !!(clone_arg.flags & IORING_REGISTER_SRC_REGISTERED);

Understood, updated this in v5

>> +out:
>> +	if (src_ctx != ctx)
>> +		mutex_unlock(&src_ctx->uring_lock);
>
>Make the mutex_unlock unconditionally above the out label.  It is never
>locked in the error context.

Yes, moved the unlock statement before out without any conditions.

Thank you for the review.

Regards,
Harshal Chavan


Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F33A6B9A
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952073; cv=none; b=BfvjMn+AVizLH+ALD6CN3QGhhMGLbEFtJa72v+ChP3abqtQP7XrLUWd5lCmSfhBmTchFc9Z+i0v2HAN3mfy4wisfp3FswOUUW4dmFheF0cYYu2j5C6yqxJzXJTMXSEWSEvedP7WsHTm83uheO6pJ7aYf7w4Z4I9YenPnllhkUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952073; c=relaxed/simple;
	bh=pBJIPnybKnLg/DdwBPJji7V9mFWY9KFpzKug0waH6Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/9XCFdkpRyAVWyLVumjxwl+8tO5rChN+QBGXGbX1/f451EbW7Iw4FgZNsx8SuxWrhhGSmwgIf4JDrye6h5+Q1Dx0eJy4MquWAblXdQXxL2vMG333xaqkZsefB6OGAt058xDmyHCH4wqpI7vG/xlkWRoGJvBFBXlxjmoq3GrZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ2YSgSe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ2YSgSe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1361584f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774952071; x=1775556871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHAguR9gpH9bNNCcSAAdxkGuK61fpqt8X9EW7Veme/0=;
        b=jZ2YSgSeLYlRefI7GcScWp5fKAnDWwiNg1GnxFb5Hgn80dosCDAvxAnRz7oUO3NSFk
         CwpQy85qSicoLJHzyK11bFVy0a4Z0phC0T0Mnif2DLaIWpuqr1B8ZIMlIrmeFKrlHRjV
         6kEDctfqEYI9hJ4YkvcanrAjWksXdQnsOB0Z3lXUsFNyM5jLSPZBwQibhVkxpjRLbkV6
         HQVorcb1YAQQp9hn+sRikCXZPpeZXnabp2Tvyu3oaEv9TkJ6B3nryrxRfuwsqfMtUaCi
         oanaPAyPmPHz/Guzu4o4drDGUrZWfhF+OebBfnATM/T1/4kAqRRvtnkCyTQu0gTD5PNP
         0RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952071; x=1775556871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHAguR9gpH9bNNCcSAAdxkGuK61fpqt8X9EW7Veme/0=;
        b=ZdZOlkJj4TF2TEnfqnZakOKmPP+dB4yTsG2JINbK5kSwXKX3I73BpyQ5frmahBYhd8
         +NuTg+UHtGGqa5+l6/kWyXUWEt4ZQ1trRfA5yexPibirvZlgUzawFafDwFZz3LA3WDGW
         v5WNkEHjce0mpu0d69SUmWBW5TIBp6VvWlZfTCVJvLfBxwdcojU33WtVcDcLUqpAlhJK
         +c4BLjZ6NiEpo9sp5LVzf1RSXdoxppLfhkuuSBDWV+KqP76sjwt8OWCxHVc4P0tAMZ79
         gz188Yvd7tFLnfY6vNx6lh/6C7mQOyQ4KXSTbi9iee9FIpmT55Xvkvl51mB7YfbaH7Nk
         Ly9w==
X-Gm-Message-State: AOJu0YzzxUZjZpq8DIvouWrGUq62DJFkxagiIFlDlx6KK4v9DfW4IHVJ
	KMaO5rfW9wGAmYTyeH2IdNWdBAGt8t6M8yTRn06bpdP8YZc9+78wUCctmNmMGS71
X-Gm-Gg: ATEYQzx3U3Z3ByqGPUUaH2OoVPm5vaDqzou+nHfS0fa9ghoetVszK0YOZfd6DMkvThh
	qptzYyNgEv0Y1Dbnh/Hq9T7ryTQyqcLmXRHXXQ/QJj6C92CXclSJgbXBJX9FPrHoCPU4wRqavjf
	vTfGRS9tKY0igL2A5gH0dShvNRWLLifddivqpei7ruGv6xNV44vnJxul6zMWQFdRN7U+bK83H46
	HqoExgLHwOHyPpRvfiXkIJ5UBtxsLxQTxX59GiAlxEL5AlJrMZgSzmIUwKl10S7CzIYwsgRY/Xd
	FhuvzCChnFhsXYfy1UGU0bWECqAivMCaa2SIbE74Lrs/FaDSjWT+UwOUG5/fDnjJsCzCKEP+zQY
	YRzhEA31QS+uQ5vh4hQUXqMrVlKAMCLdAEfUDNLR+hZxJ/8wNDxFIBGx3N2ZIddWpmP9QuHuztd
	mHkK78CPAuj5kGZYiNorQxeOaemujfuukFN8yWafTbUP490x5mCrUckHsc5o1V0RQusIbZRgo=
X-Received: by 2002:a05:600c:4e15:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-48727d5a16fmr270937105e9.5.1774952070406;
        Tue, 31 Mar 2026 03:14:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm26530635e9.7.2026.03.31.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:14:30 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:14:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <20260331111428.0b0575dd@pumpkin>
In-Reply-To: <202603302335.0AEEF9154@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
	<20260330132003.3379-3-david.laight.linux@gmail.com>
	<202603302335.0AEEF9154@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 23:36:07 -0700
Kees Cook <kees@kernel.org> wrote:

> On Mon, Mar 30, 2026 at 02:20:02PM +0100, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > If the string is constant there is no need to call __real_strlen()
> > even when maxlen is a variable - just return the smaller value.
> > 
> > If the size of the string variable is unknown fortify_panic() can't be
> > called, change the condition so that the compiler can optimise it away.
> > 
> > Change __compiletime_strlen(p) to return a 'non-constant' value
> > for non-constant strings (the same as __builtin_strlen()).
> > Simplify since it is only necessary to check that the size is constant
> > and that the last character is '\0'.
> > Explain why it is different from __builtin_strlen().
> > Update the kunit tests to match.  
> 
> See also
> commit d07c0acb4f41 ("fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL")
> 
> -Kees
> 

It is far more subtle that that;
There shouldn't be a run-time access to __p[__p_len] at all.
And you really don't want one.

The problematic code was:
	if (__builtin_constant(__p[__p_len]) && __p[__p_len] == 0)
If the compiler thinks __p[__p_len] is constant then it will also
think that __p[0] is constant.
So the extra check should really make no difference.

I suspect this is what happened, consider:
	const char *foo;
	if (cond)
		foo = "foo";
	else
		foo = "fubar";
	return __compiletime_strlen(foo);

This is first converted to (ignoring any silly typos):
	const char *foo;
	if (cond)
		foo = "foo";
	else
		foo = "fubar";
	len = __builtin_object_size(foo,1) - 1; // 6 - 1
	if (__builtin_constant(foo[len]) && foo[len] == 0)
		return __builtin_strlen(foo);
	return SIZE_MAX;
Since foo isn't constant that returns SIZE_MAX.

The code is then moved into the conditional giving:
	if (cond) {
		foo = "foo";
		if (__builtin_constant(foo[5]) && foo[5] == 0)
			return __builtin_strlen(foo);
		return SIZE_MAX;
	} else {
		foo = "fubar";
		if (__builtin_constant(foo[5]) && foo[5] == 0)
			return __builtin_strlen(foo);
		return SIZE_MAX;
	}	

Since since foo is now 'pointer to constant' foo[] is constant, giving: 
	if (cond) {
		foo = "foo";
		if (foo[5] == 0)
			return __builtin_strlen(foo);
		return SIZE_MAX;
	} else {
		foo = "fubar";
		if (foo[5] == 0)
			return __builtin_strlen(foo);
		return SIZE_MAX;
	}	

In the bottom bit foo[5] is well defined and known to be zero.
In the top bit foo[5] is UB and gcc leaves the code it, giving:
	if (cond) {
		foo = "foo";
		if (foo[5] == 0)
			return __builtin_strlen(foo);
		return SIZE_MAX;
	} else {
		foo = "fubar";
		return __builtin_strlen(foo);
	}

and you get a real reference off the end of foo[] - which UBSAN_LOCAL_BOUNDS
rightly picks up on.

clang has a habit of silently deleting everything after UB, so might
generate:
	if (cond) {
		return whatever_happens_to_be_in_ax;
	} else {
		foo = "fubar";
		return __builtin_strlen(foo);
	}

The 'fix' of checking __p[0] actually makes no real difference.
I'd guess that the longer code block stops gcc moving the code
into the conditional and hides the bug.
But that could easily change by just breathing on the code somewhere
or in a future compiler version.

I suspect this should be a compiler bug.
But with the compiler behaving this way you can't write
__compiletime_strlen() with a check for the '\0' terminator.

That really means you can only use __builtin_strlen().
Which means you'll get a compile-time error from:
	char foo[3] = "foo";
	__builtin_strlen(foo);
rather the 'not a constant' when checking strscpy(tgt, foo, 3);
At a guess that never happens except in the tests.

	David


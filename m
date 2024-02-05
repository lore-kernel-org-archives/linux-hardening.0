Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E14BA8D
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173058; cv=none; b=L+1cshc1BAKC+7AbykSjBaD3AJAP6WiLggVe+2gcrfAkfZE9kSp0JOu9CosT2JTsCZ5f55yzK8VXcrP22zWj6CKPzLn+/O5mBavFWoQTMMf1YUUswJW+XHR45tF7qUsD3cOfz01lFfi/dvdCQx2gQop53WllBnu2fds762leReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173058; c=relaxed/simple;
	bh=ZQgq1MCIgYVKvCXkNtnZ9U1EnbNFNTYyqAwvNP/4WjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SClsj+7Uyh4089jcXqofuf9rEDbJ9/uZJxuYcx9G5C8xeDS9SgREPeCf3yQZ2/18XtI+F+lmBr509iOdYlXs1YQCjyTvxvnJfQYh/zdCgKGJHOt8yDIBEB6j6JGv7kS5I5vvp1oy9ntfkKGzwQ//fEo3vZ7r2s4iG8hvl32w6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FemScorA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FemScorA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e04c4f494cso728152b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707173056; x=1707777856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlsSc3pFtKmxKFilYiWjxo3LPVslJeCkCNbb2hluo8Q=;
        b=FemScorA3FgpmqmyNWIkNg1H3g0+setZhSxFAN8BB8QkkuHitYIpjJpuo0dVLod3m/
         A5ZwdjiGrEEWPcrjWJwVNHjxQqWgHCNI0Wa4+53eJgF6l+uyemKEgwWa+UQuka5sujOQ
         1Si01k2CS5xZoF7qMh6F1Bb1OPqVQn4mTivTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173056; x=1707777856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlsSc3pFtKmxKFilYiWjxo3LPVslJeCkCNbb2hluo8Q=;
        b=bRAy2CXrGKN4dfwe3BIu7P5w4vKu8mvAGGQXGY5QiShclQPw5XPPpmyYNkxqKcJzLE
         XOGJSiZI9Ijylgs3PgQortzvD41d+HHfqmUeX9LhYRVXD3NFRe3/b+IgXAY5RGJjIld8
         TT7mHiRqLvKM8YZuR+R+RX2q7neakJ0yctVLZFC506KhSk6RPFE8AED/AIUhjOVifdXN
         F3maRZKdWbW28m1Yddf6AwrlnVEpx4FkXilj0qdaIiGBRJfRNwWB64ct8g7S9HlXl1Sy
         VKUDXlJk0yKG54L80X4MxdHAkhoR4+cay5X/+ANmqn5x1eGs1kJBCWfSaWarXBgl2ur6
         RQCA==
X-Gm-Message-State: AOJu0Yx802oZFWeSSrwkAT/CRTt2MWx+25BlRHPYsKaZ/RkOzKg7Q/Hp
	vYDJSq5lV4NbvsX7m/Rr3OPsAW9KBF9DvFvCBlmS6J+/RWs9IEnIyAw/TU5/8A==
X-Google-Smtp-Source: AGHT+IE1QBh6gexcQ+2X2Gc5NMQeqE3k7X4xb8teEBAWlblyskPJ73kN16UO1tfLOwj40JT2WfGZ/g==
X-Received: by 2002:a62:cec3:0:b0:6e0:450c:4a28 with SMTP id y186-20020a62cec3000000b006e0450c4a28mr761387pfg.29.1707173056004;
        Mon, 05 Feb 2024 14:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUv8l7nHBzn2Bdlub4E1yxV75RGWc8+YfI/ZYUKbrk58oaZHuJVOKCFMyxtvcBbuHCJfRv54TwpsQ7oF6IHvjR/Ubalse+Y+AegHLipH7c0uAej5DDm1C7P0ShBhVOo1Y5oN80ZZsHeKZXzSpJ2nUqpcDFT96NANp+kB0vSKnfnntY6DT4JMsucdb9o8UpfrGWGBK0zQ3AICs1n2KSrms02YxAQoDWAMw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn11-20020a056a002fcb00b006dfb8105235sm392409pfb.112.2024.02.05.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:44:15 -0800 (PST)
Date: Mon, 5 Feb 2024 14:44:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <202402051443.A813E4D@keescook>
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <20240205202145.GB2220@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205202145.GB2220@sol.localdomain>

On Mon, Feb 05, 2024 at 12:21:45PM -0800, Eric Biggers wrote:
> On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
> > Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
> 
> Maybe these should be called wrapping_add, wrapping_sub, and wrapping_mul?
> Those names are more grammatically correct, and Rust chose those names too.

Sure, that works for me. What bout the inc_wrap() and dec_wrap() names?
I assume wrapping_inc() and wrapping_dec() ?

-- 
Kees Cook

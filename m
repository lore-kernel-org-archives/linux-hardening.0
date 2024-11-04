Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965C1C9ED1
	for <linux-hardening@vger.kernel.org>; Mon,  4 Nov 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744464; cv=none; b=n7GdScXbBzInuKnif3Iuf6N+/QVwFeQgmVWepJ+BExndY5ATM1QsAULgQm/oJeni8eZ3xeiGKi/LATHAAbhmYrlLDOhAAz3hhGfr47s/O5nu3/OQSGxhlAQMlzoV3Wyh3J5TKGFMYVk9qO3nl7h/5NZ6LaNLL/OyZvJzFq2QraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744464; c=relaxed/simple;
	bh=M6xDzNAKcs36VWJmqh7kjILMTWmZO9OGbW4mqT6HmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANXxve2sQmLU4Jj60COSoUf2kJAZm6f/Fd1ECN28LhQuZ+59QrR2HYz5naVczhv+PfQxKZMeWuU3rociMxlWzulMvMjPsaVNxbf1yGzJp/4z4zVn72kDHK2QVN9K/poyXKTTUyj/L7pajOLOF2ye0FfEcWortLv+Oar1psi0TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBWwq264; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBWwq264"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eac969aso27924945e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 04 Nov 2024 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730744461; x=1731349261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvgKojtjxMMS6cqT1h35DY7bZCxI4idU/B1S0RQ7cd4=;
        b=kBWwq264szWaphLKiF9s/eMuSNA6tvH37jOs/B4TBl0RQzxPmKzZu4iIgfXEDqj0VA
         G/LZ0wi9JpyPtN9tIY9orcifFYVpXCs/rxRhPtGypf/CTWso/LZlpUJde/EjzZN77SKr
         qjbyewRA32ztUzEUzTMGwCj9jC7DMtvFe5bEjB9faQPrUMmcIiLWEyWae2N3tNDPUAtO
         oOXjHeUnwiUl3csBUYxMQtHTgOSKmy1eX+XwSRAbBQ3I4mZRJ7HqNryhA7fEf7lgLVtf
         Hj5q72WFEL4lhxNT+FEWJ8jdhQ8LAZ4+tBoLTyF6DHogJhlRSejlrxD7WLhykz0IScT3
         DsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744461; x=1731349261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvgKojtjxMMS6cqT1h35DY7bZCxI4idU/B1S0RQ7cd4=;
        b=tkpVzl3mAvVg3sID4VzaddoRyuCsIjrTctHp8xPG6VFb2eDzCUbgK/u3kJFeF1dxx+
         0S7d/261MC6aO5tC/0rGkdrDL8cc5TTiNuKE4B4ELaiwgBi5w9kY/kVNRfSQcOZz3VVR
         ZgahfW8Yx6d4wMQvrQmTsNZMyO1l7F2wBxX4qjkacJqOp4Mc6ALEjBi5EqW9+80mw4bp
         PJdm2bTgZa531Qm+WteHC2bQ0PgY7pQOUOQ0JQRDqTaaVs2TNHszPOLBJHsCHQWIZkq3
         TSb8f0o1eLqn3WGFd3ughM8oseqISHsauE5YQLUx4t0YIlZ3lpb8nErPAP/dJNUdRtYv
         0BnA==
X-Forwarded-Encrypted: i=1; AJvYcCV3e2ZWNA7s+jii0XIuGNpCfpNRfAHtjXbTe4AgxWqgZ+e61nXgZcPtxFSUlj7bCKAaIuzEroa1baqKjrWVIWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYs3/rNTw7NCAwQgVIs7Drzrdg0IZDYT3zF8uyu3Wl92DGQZRh
	MhHhpscJo1nhaeFS7aUwr68idNm9zwNddKU+3w35S13vONM0qsbpCDhAjSN0jA==
X-Google-Smtp-Source: AGHT+IGCf2kXxmfohJmBXmuH3j8pJHDrbqFMRzviLHJM7ILP9HJYPdAB1K5kN0pfn2Myr89luXLdlQ==
X-Received: by 2002:a05:600c:4449:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-4327dac7732mr131855855e9.16.1730744460604;
        Mon, 04 Nov 2024 10:21:00 -0800 (PST)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e2dsm13835508f8f.11.2024.11.04.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:21:00 -0800 (PST)
Date: Mon, 4 Nov 2024 18:20:57 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <ZykQiY0jvxKqrCIb@google.com>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
 <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>

On Mon, Nov 04, 2024 at 09:12:09AM -0800, Jeff Johnson wrote:
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> And it is exactly this kind of issue why I'm not accepting any __counted_by()
> changes in ath.git without actually testing the code that is modified.

However, I was really lucky that my setup used nl80211_parse_sched_scan
during normal operations and triggered bound sanitizer. After the patch
was developed, I accidently wiped my device and couldn't reproduce the
bug again normally, so I had to use iw tool to trigger
nl80211_parse_sched_scan manually to test it properly.

I looked for some tests that cover this function and that I can run on
the device, but couldn't find any. It would be nice if you know about
such tests, so I can check if there are any other places where bound
sanitizer may be triggered. I only know syzkaller tool that may be used
to get more kernel coverage in general.

Best regards,
--
Aleksei Vetrov

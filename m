Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4826ADE
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049601; cv=none; b=OSBh3X4AR49YiFNLehH8NIpPdF9eMT4GLRpuCLHfxyKbcNcA9grSp6WruKHkYdRKGKOyBGC0brDi7fdF/5WtQcnJ7ZMxclHEOIkXr8rFT/HNswiz177T8FP3WHfHiu/uxLsu0pgFd98YKzn4LZb0t/XxlpLfLJCF+/pip00J/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049601; c=relaxed/simple;
	bh=y4p3NSPVMHOw2jwP2PaoGxz4TfHUbU+fk6wK9jRWntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q23LVRZsODyxq6+z+pihiKzlVzczk1YuMsYqNE2eBgF3kO4R7LwnFxoeZFoM55j6NAd4I/yh2ztFnpP57xLxz7riI6R2hisBN3uLx5cNsE98tKa6OF/avqwrsz3d7gxIBWVn9BgX9c6WzlBdL3h/D/4LJv8IBFKm/FbyBN5Sh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m+wEVrLu; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m+wEVrLu"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5989d8decbfso3074380eaf.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706049599; x=1706654399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRnu4PK8Uuvutr3TyIu0/bpXXmqyY31McaVpbSnGREo=;
        b=m+wEVrLuuRi+1FPxBF9qzyqOabNu++xYY2FrdjITdCZ8Tf1UsElWcn3/Y4Ag9TkEnc
         ptrpzj89EoRwiH4yj8nm24pQK8DxjbqP6UtWdEWo0uUHAv+3LV1JEVX5SAo9AF5Yh8Xv
         Nl39xAu2AVK5D+B2qBan9NudAxBEx9iqBTyU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049599; x=1706654399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRnu4PK8Uuvutr3TyIu0/bpXXmqyY31McaVpbSnGREo=;
        b=etqysYi1U2J8uboDAIVCtJvh9tdPeiIAMbPHYrewJ3TMqAfdipXI6RBZCtcKz5AU4X
         r9CngqQKdZrdIrNvDa14keEL3C48EZWEvooTYMtvamw2YirXC37RdcS1abSwSxv6dMzB
         tcykkplZLExuz692GLKSgxRkRr5hXahSdTzLior85PvQsmxQR6gPHZzopDnsn9PjI0NV
         gIoBb7BMv05mlCE2RrSip8RWE9YW+qGLWtpkpH3OvLpMpUkS3XrjZbWt3CnBcEpnHn9R
         BQiafmgsJp+OAaHN5TQ1MVbIcH+ZmsRD04oXqoGIjBmuccEHvn5Am7dYKqN37VwA0YYI
         jHzQ==
X-Gm-Message-State: AOJu0YxHS7ftV7d0kOdhbabextqAIkR9NRpbTATSwGnEVX39gXOrIgEp
	xk3vdRhDXfWug9WjHCknRVF9oSfoOy4vGQpODGYVUP0nWvsfzRx4kY/5mizHghWHY5lf3mw6c24
	7+A==
X-Google-Smtp-Source: AGHT+IH8X7+qM+5Il52aCRyzlGZQBCRCYjN1AqIRKfNRJwN8eQ2rmq6FaIDOCAhd3c4e85Ex76otBg==
X-Received: by 2002:a05:6359:4c1b:b0:176:40e2:8902 with SMTP id kj27-20020a0563594c1b00b0017640e28902mr4515945rwc.0.1706049599143;
        Tue, 23 Jan 2024 14:39:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a65518a000000b0059d6f5196fasm9336883pgq.78.2024.01.23.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:39:58 -0800 (PST)
Date: Tue, 23 Jan 2024 14:39:58 -0800
From: Kees Cook <keescook@chromium.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-toolchains@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
	rostedt@goodmis.org, gregkh@linuxfoundation.org,
	ndesaulniers@google.com, justinstitt@google.com,
	torvalds@linux-foundation.org, linux-hardening@vger.kernel.org
Subject: Re: A few proposals from the C standards committee
Message-ID: <202401231437.171F50B769@keescook>
References: <9162660e-2d6b-47a3-bfa2-77bfc55c817b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9162660e-2d6b-47a3-bfa2-77bfc55c817b@paulmck-laptop>

On Tue, Jan 23, 2024 at 08:46:13AM -0800, Paul E. McKenney wrote:
> N3201 Operator Overloading Without Name Mangling v2
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3201.pdf
> 	I have seen Linux-kernel interest in *function* overloading, but
> 	not in operator overloading.  Nevertheless...
> 
> 	The trick here is to associate a given operator with a function,
> 	so that the name-mangling becomes essentially a manual operation.

The proposal discusses strings, but I would want to immediately use this
for handling wrap vs trap arithmetic (rather than using sanitizers[1]).

-- 
Kees Cook

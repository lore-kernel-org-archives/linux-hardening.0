Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B514BF9B
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078680; cv=none; b=QGx26o7ELIvXL/dzucoMF/tW/GCI7Rt3Ble64lKpB6nNDIYIAH7wnF0WNA2gnzV2Zh0rQFDHNGRf43W/6vs9BaoC3e5cD5z9tA8MOETMkAhWDz8myB7rBNYOMVzth4eLYAs75/OTYDXUlx2Ki4+jGcYAROEhQekwKha0g93A1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078680; c=relaxed/simple;
	bh=5oNgEmljdB6NKphOsBQ2rXcl0qZAFG/RxtdNV0s6mYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdU0g262NE4rvzco2RZwRhgPtubNy8uou7d0TgdoIv94YXK/k7VITpb6AJYrz2ppV6cQSulkFCsej1k4sC0yorAylt/FMePbTqLMsVS1GyPO3sfV/f9LRt2Ml2BMvUEwBgBAfzgW//DColET1Z2CCXuO3YZFBpwVsh7MiZGtG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCTssiGF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCTssiGF"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so1173139a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714078678; x=1714683478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZcutr+DBU8+7Q1m43Njo0i1Yp7GDDxZafFN7u9zRq8=;
        b=FCTssiGFEiHsTjRsr84PBt+Or5GPUv7EZ8Y9DroxVfP2ckogf2pbChiFcPYFxelt5J
         xqxWIp7T2F87TH/eF4NoDfaEHIOgLrlE25sN1Su6EcCkY8lQWNwsOY8o1y+B4UJFXUFS
         JJmFK7U4ZoTgCl7D9lDhGakrVLifM9kgORAdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714078678; x=1714683478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZcutr+DBU8+7Q1m43Njo0i1Yp7GDDxZafFN7u9zRq8=;
        b=h8nwdBYZt55fB2bzjOfyy8ybbUTYn5gNZp6D/MXUIzlaGcPm06297MQKfao2izvx6F
         afR/cKOValeZlxXV5LD2ke9R8I1sAU9G4stwloafPfSokcL37R/v7e2Mz9AGL/LSfivp
         ZXMFA70Byr5JZorP6EB6yGjHA7MwxK9OfpHbaPznO5Z0OaxOYolmQZd72ow3t5SRwaB2
         iMuMXJBYk419x18byU3jYwKV6sAY3dVoLkjHYs5YALW1IwIW9rwz3y5El9gyMleW0AJv
         QawH2y0/uHttf1jKx9WJbfmzV8Dueocpz1u41nt7CPAFyHFYDajUO6xE3dC+H9YcQcXr
         vSOw==
X-Forwarded-Encrypted: i=1; AJvYcCUFHohih1x8meGyIMYMCcSSNPx6PKP2km46qMRZ2yjrGX2IT6gMYtmPwQNfCeWOY2PCJOFYyAe7nVIiDLYRUwB+eWFV5Uod7HM/kUDNqAHc
X-Gm-Message-State: AOJu0YxvUEXhF46vlYGYERwAAHFRdETr93jDhXbSoz9KmgrcUwVOFZZr
	hcZl+eqCCcJ/sThpvcJ2qer+l+srOfppcAwLV0KAhZt0H6UqSop5b7u6/Jh1GA==
X-Google-Smtp-Source: AGHT+IGfz5Rebw0b1ZhwK2xIUu+dXp0C650WMXHqzg55TZk2O1Ojuq+nNXtUUs8X9rCbcPWJ63x3NA==
X-Received: by 2002:a05:6a20:1581:b0:1a3:ca86:be8a with SMTP id h1-20020a056a20158100b001a3ca86be8amr1084537pzj.57.1714078678515;
        Thu, 25 Apr 2024 13:57:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001e895c9ec6asm13735852plb.152.2024.04.25.13.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:57:58 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:57:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251356.F694909C63@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>

On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > The /proc/allocinfo file exposes a tremendous about of information about
> > kernel build details, memory allocations (obviously), and potentially
> > even image layout (due to ordering). As this is intended to be consumed
> > by system owners (like /proc/slabinfo), use the same file permissions as
> > there: 0400.
> 
> The side effect of locking down more and more reporting interfaces is
> that programs that consume those interfaces now have to run as root.

I'm fine if you want to tie it to some existing capability, but it
shouldn't be world-readable. Also, plenty of diagnostic tools already
either run as root or open whatever files they need to before dropping
privs.

-- 
Kees Cook

Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5A19CC3E
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786673; cv=none; b=JtcTrZ7/TXhOvnpj5hWMDYgqwsDxULKsYc6jNSHQMH2ZL67wqjr/7RGzvUBYkxiwhak/RMOzGjDmlrZrGHvZvgR0jPcTpgExC0X8ObLHN3thaPZMhT3ZXblhaRHr28iiAiBsccarPjm4kSGYTJ+JhnnJNl4kxFiau6xb9EFp8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786673; c=relaxed/simple;
	bh=U0HtHK1poZiGESOdrOrgpOi2G5JJ/usr50rmbJv/Gfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7UZGW3sA8BRKqBtyZFWiLpuzmRWDYNiUA9RA2jvRWilxz/I72vWvTceFaL5gotl/V4aWqorKCBFDK13iEeK5hlsgSbLm531jljqFceMsl+lvvnBSVl2OoCszuNZp1LA6gsOfzBkzNiBQ1LAMPCFWts5v5VzDdGRvytulfLRvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ugfb8tXw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ugfb8tXw"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so6142929a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739786669; x=1740391469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9icW+RZ9BUlJeT9qDjb0oU0qZhKkpwVHO3FgIOiJAJY=;
        b=Ugfb8tXwDraXTkCGkw1gaKp6Rm7obJgIuteSycDrPz4OdfTUVHZRbKktJ0QyVW4wjk
         oQekwS8opN+9jqRB32121H4iMPDUNKNr8627bzGqWLroAwdZxWJwit7fxizVtSqKCUFw
         xKyeYLIwK01gDfpbRJckezApr/CzIkenOMbDpYL6OGKarmDaiAC9swB2egudBcgYd3Tx
         sWfnh/uf/5fnm8Z3vCEi5hNtK3hPikk7Vdwr31njOZSo0BuVf2LadDB+p81XbJO9HK4D
         y/nAONM0McFfDCGAjaCwDBpbRg5vEdR80LhQWSi4JxZvXL1R4xhtVttFmI44GJZ1g27v
         ZWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786669; x=1740391469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9icW+RZ9BUlJeT9qDjb0oU0qZhKkpwVHO3FgIOiJAJY=;
        b=bcaMKg86z9TGKM2SL4tUBN0bYHGwAqd7WP2ptWkKJ1/MglkJdes8HMj1DksHqyvKQG
         D40YGTBUPn0K9IWNUy0F8bVuGDi6Jh4JFOk4IbVIXPjwYOhKi6A1QIE1+xJgJ7bC0Aed
         9Xom2Ktp2JL+GxKrv1Uy8ALaq94NYjRv1JY1kA1TNcA5fB+ewl8wbG0ehu57hbohSO0g
         Mf+PQkAzxB7PJ6bZU6nBmNeqR0cBJpZcbkqk7aPjCQ2LfPq+LiUP2B34iEU2NQ5bPbmB
         WH7WUAw61Q/0ABop4eoypRkVCVr18VWp68vw/AJPhmxx1vgKUq5KULvq5/buL1Mh3f9h
         rHwg==
X-Forwarded-Encrypted: i=1; AJvYcCV7DLv/cUSMMYs5SREBdD8II9nQc+pBzbYrpFiq6QBlXon5oLv1mLBhOoDtf9r6jhQGbMqdqXkRH0urtBhy3nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhhRJkd1uWqr79VuBAGo5AHxxUNjkJep1wzgfQy3pa3pLNPpu
	M6usRfx8IWVe1r56Aft8Zh8VlyE7XZCpinUKi5eO67ya/TeA0vfENu876UKiCkQ=
X-Gm-Gg: ASbGnctzOfx9UUkMkZLAGBzpZcYaPGrF2hKvRTKW35Ox+YYEpQ/9y3qfGFRE6FKDoyQ
	eaqR5ht9dRqmgGhkse3LGYSby4V+HFbpFUp9XNJ5jG/aZz3Nfyydym5m6QHLSmj4323DoliSxJV
	xv8JNzdCiEL3BW4riNIZ8waKt92gy1/PBsO2+9S0uYztQuuvzkZLSB8odljG7kQ8ZZPFvus1eWC
	jLhOT8Kvw/sOZD/YjhSqRCE/Ycdz2PnlLGNhx3+p40rQFeYS7euSjgNKVk9aN8EQElbtKj86lke
	fKk306WjI6zm49rF1J0=
X-Google-Smtp-Source: AGHT+IF6opUQlIwxb92mSmm1gEo9G17RkPSkKeifhJ7EJuyYBZxee928DaKRSRvvfQmUPMLsNyXEjg==
X-Received: by 2002:a17:906:3087:b0:ab6:e10e:2f5 with SMTP id a640c23a62f3a-abb70d950f2mr787890566b.37.1739786669553;
        Mon, 17 Feb 2025 02:04:29 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb952c7364sm234250066b.18.2025.02.17.02.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:04:29 -0800 (PST)
Message-ID: <c8cd1730-9472-4b02-9828-d1a8221fc487@suse.com>
Date: Mon, 17 Feb 2025 11:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250213221352.2625-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250213221352.2625-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 23:13, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that the reallocation for the NULL terminator
> only needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.
> 
> Use krealloc_array() for the additional NULL terminator.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Queued on modules-next.

-- 
Thanks,
Petr

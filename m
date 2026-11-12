Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501577;
	b=owEr8HhZFMDl8YqgV2NmgOlIoWnxPbvwQHBUCBPuaeYA1oj0kqhQcs5fr6B65+bw1cng
	 cc1mhHVpJPhPMpCvQ4w8nQcgEXMyU8ZsZYM8YS5xInwvhnF749Vxz6/W4TSJScGjz5tpv
	 MEw6sIFr9u0wOk3nVO30AcwXTfcMptBgW7SiJPvRAt5/W7wa2jdDg2+2+67sUodRWl/IO
	 AJQCfGsqUYyC6Mt7F7MJkp9Qb4QcZ/VdUtnn+gRk6zE8b2nO3NVgHYJLt8ecD/eYoK9fs
	 IdHTWjjio6q/IxcpyCnYOSrAqxmOhxl8sD65PmZ6+R7VM6RDPFUggbyjY0WKfR0za/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=BkOan397muuCEgFMqk3a5KpizGYyvJYTBVZxmg+BXRc=;
	b=n56LewgicCWV1Pnce2771COrSSCG9KwbZmJaPUEZCkAN7nCvpAcWdYn9QQOeFcwlQlVb
	 lU+tHR0RvtnAeIBQXCHy0HeEQzca2FjCvBhq/y/bBQzjDgXv3A+yljI+mm/7nWSv+Ys6f
	 MKvY6m7fg3Sm+39cJ5eRRdePA4VonIuyLCBchM9HOPRN0B9ipwCmwxi3TnX5CWlhjuuC6
	 iZgQq5TC9yTcjygXQjR1Audg4kmPGgV61T53RozAE2cOMaikccezzrsNwGah72p2/KKo1
	 ecWbHmDhzoKfxH1rMEWdx5nP109A8wBl30Z2wYZ9KeG9Cen+/xZeksbssj+lj6ELzJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=V6D5XEas;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540C606A885
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 16:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2540C606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=V6D5XEas
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b7a488a0a4so9823a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794501574; x=1795106374; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkOan397muuCEgFMqk3a5KpizGYyvJYTBVZxmg+BXRc=;
        b=V6D5XEasvn4gC3auGdsSsyBlPnTYNxI8J1uoZ1lmKyLQRiKuyh/hRw6HPL8c18ZOrD
         kjteEtOo2MfMK5b81CIVE70QxR0U+CK99YsD9yeomzMBtBkO4lyvuWqufEDo0jmFf4NU
         g9c5Wt+U+OMm2cyXUQHmtknT+e4LobZJXcogM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501574; x=1795106374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BkOan397muuCEgFMqk3a5KpizGYyvJYTBVZxmg+BXRc=;
        b=namcKkjwT9kkHICMrkBNHC/yFgUFEM4Lub5BW/F4g+3KinBCL++wwOTMP+Vq/HbTkW
         PKxTKSyvyxx6Ho+Niesns3BGtxx/yVHfHHjX7uxhpbz7OqfGy5yXKdKqjrvpmL8XDAsv
         YYGYzcAp0nUBDwWYLFQPtbDuhe2tT1Ph0+3xRlJuTSCpWqkXcvK7u+uCNg0TRZGWbse7
         TOgLjV7leKYVFU+NNire4fzJElqbVjWAzuSydone0oN+CcppJ/qkGDhXtanzgMNnoGDt
         hrVYtEpOy9bOODKsDGwv+whybjA+vpBWjw9tZZgOqaWOLP3NMufOfrLFdHPucBsm8+uz
         pL8Q==
X-Forwarded-Encrypted: i=1; AL+hErEdoUhsi0OwLKFEPCO/Vlcy/9EMMhlKrL47xAgQI3wWcHm2ZS2TDqf2nRtRu3wY16P7XJJ88g7w4bTlCxKwihg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JRzfTLesFBSHczv7ZRTopT9mg1TA/jq7KEh80ad/mToCftoRu
	6sCsCogUPGjoAaZ8pkdar16hFges78hNkPPm0FO3cksGVDg0TJtt3RAKz8+P399rTUp2KjTEekn
	DSvZqWnUDJQ==
X-Gm-Gg: AYBFou2frGWjkxT1Ey/m8n1184hQr1aLlSHgYP6r700W7dg2HeF6uQ+umQi/eS30K4S
	a+nPpWxBm+kAg74ah+MLgzjmXFvwAKrunus3Y1pz2qT1l00ai0CfH8e87k7cXlrA9OwdDq6qwuD
	GBrb7DAnWYmE+4jcemvuHCwWA2Qx1CLHjyoxFRnLryE6tHtW6lMJOLnnR40x1v9E4IQZp0bCarR
	I+L2Wm6GVOkf5GkAepXd31zMvgbm89ntBWTwSzEGeH+mLlpaIVUboE8DSKVkQLLwysd2mSFnOWc
	gJ/xDcFS9K7agfrzeFWol4PnViVmkXxGJVKRssLAE+jLn1V65D+6JUhG4fcp1vlVvSLSmS8Fi+U
	3yZs1wSRpGUROMuicOE4SOA0ULscQeALE6Lwwd1XY8NtjKi0nVirp6atr7uktJvYw4SSjOtMe38
	IQiVPLsLubF++BNsEIBapca2EqKXZAZyeJOqONisOtkO0jsGW6epChedJa7t1DcvP2N4bzGW9ry
	KAnnmAEKFtsXS3McNsKMSN859Zc881JvGdT9G0CH4yVH2IENjTPekqvGIoLq8EJHIRZ+7KJmt3b
	z7cPCmcQPZg+XXkEky3QWEHyagpCEXHCkfrJS9igU9zrCfNQSGcCYVjd6v6z0j2ahPNlUFFaSDo
	O7Dw=
X-Received: by 2002:aa7:ccc8:0:b0:6b5:646d:be38 with SMTP id 4fb4d7f45d1cf-6b7c0c75492mr75904a12.28.1794501574396;
        Thu, 12 Nov 2026 08:39:34 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757911e2bsm3722567a12.36.2026.11.12.08.39.34
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 08:39:34 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b7a488a0a4so9807a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 08:39:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGhUWggUaHMitpZKOUbOVJZAY8gF/GYk+gp/ww3tbS48Iu0bBh7BQJaYv7B7aEPgk/VFfUVhsvcb7fxFyXh+fE=@vger.kernel.org
X-Received: by 2002:a17:907:96a5:b0:c41:e75e:5889 with SMTP id
 a640c23a62f3a-c5066b5bba0mr524017266b.33.1794501270421; Thu, 12 Nov 2026
 08:34:30 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260914223212.i.829-kees@kernel.org> <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com> <avWNCC3_Ff0knO6J@devuan>
In-Reply-To: <avWNCC3_Ff0knO6J@devuan>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 12 Nov 2026 08:34:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>
X-Gm-Features: AclHuK9Nmkkll1Jqx8Ewj5iXnIEjw3xkEvFj8OVOVXeQp99rrxeYYFJHUsjvVTk
Message-ID: <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for devm_kmalloc
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 02:13, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
>
> I suggest removing kmalloc_obj() entirely, and using kmalloc_objs()
> always, with a second argument of 1 when we want a single object.  This
> would remove the risk of that typo.
>
> I also suggest having default arguments without variadic macros.  The
> way to do that is using empty arguments.  Linus complained that it hurts
> his eyes, but it really makes these macros much safer.

No to both. These are both "make the code worse to catch errors that
the compiler should have been able to catch anyway".

If you *really* want to catch them, make "gfp_t" be a 'struct'. That
way even compilers without things like the restricted types that
sparse has will catch at least that one.

I did that many many years (argh, decades - I'm old) ago to catch all
the 'pte_t' etc issues when rewriting the MM layer, and it works very
well.

It's going to be somewhat painful, but ti might be worth it. People
who only use GFP_xyz flags to pass them around wouldn't notice.

            Linus

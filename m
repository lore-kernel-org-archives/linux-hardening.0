Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAA84A27
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254202; cv=none; b=iQL6+QgRkhQ8PT2s8eUpUeFnt3NVFLULymBfa9sH05kKHf2NiAn+6jXszrmgYvgqG+ufCm3HetvA9QOjUS2hcVsXkEGwyHlHoqTkb5jWhVZshozG3dYiA+un741l3tsCR6w92dJnMR5NthVXp/V9UtK3gmCkZ0wZKfwQsDjMXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254202; c=relaxed/simple;
	bh=DejRZZDbvIwg8LB/2rtU2ayjqdkKF06fnRo4NPmr88I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Nnbhw5ZnTn32wVJgzy4aCKULRmxH8mLOJ3+bwA84UoKjR8xk6FUX0DBGo5REBIQBQZnO2u3IecpVfq8oV6qcgz9WCbuFMEw9/bTq78Ew2raLMQ5A001ZRIHQs75D8Ff4LeH/CsGlfdbKNznHuIjVnJcK4A+C8xrYTGFhv6c5eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=iukORuk6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="iukORuk6"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a91c8cdd5so24694666b.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726254199; x=1726858999; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DejRZZDbvIwg8LB/2rtU2ayjqdkKF06fnRo4NPmr88I=;
        b=iukORuk64fW541Mp9zsgDeomRnuhsTpFcq/ir1sfeNzcyRXmCSwR0kSdKKC/HHkTu+
         LT6Ojdfxr6OXh/YSzQjFUAuj1fkUwM+jyKrvXQ2Dl+sC+SskTogiqUa8QDDZlv12VYdZ
         I2CzPcW8O4MOG9/4b8ZSheK37r/qr9EfCFlxs/UASVJYdT4LyLyUICKjQMHhFrWAhEU3
         5eS580x0PegH2Hl07ApL5lipI3gFcEuV2YW0zvmGs/FT5951YdsqesnWPI7VLM/M9NVK
         oeRYgrBtA2k62v6hDUfOgJfjYENr3yvVple/UGCwn4nTCqjgMfsgh/Ug2LS9HBpYrX3n
         PxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254199; x=1726858999;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DejRZZDbvIwg8LB/2rtU2ayjqdkKF06fnRo4NPmr88I=;
        b=YAsr6tU8RpL8+C6AbAgswBuDloW0AO7Hii8fmtvC8lQ874sb06fw0qrDW1+uZRoVDM
         bQn/KAdAlv97QUUxcgyBf0gcSlaJdNbvoCap6srJocysk7MjAPs7nGEV/y78k6WAKbwl
         h6rH//Iar3I51S11hU9PpmyPyH5IX8tikbNn8DhiPDyeW9JqKKhp7VScXKgWdd6vQcPu
         WPKgwMjAwTRJWt1RFuOINEZ3DA7nEP3u+ppt2T0oYZlo7tqiL6NxfEQNssuR8iSgrYT6
         XoyMi5aRC+lsJiU1eDUhJGBpAcHS15bA2bNI5/bs20Mtmo4Lcf1s0Lg7J3F6E9Yl/qwi
         3LZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxihIeecjWyhgV5ZGzYFvr1atb1Rl4gW+NdVVYfl1OTfaRys6DCW6FoJX00iV67F3sJLL7XPc+yq9TuF3v4sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0yJDbB7r77eisDLA6ScL79pWv6VNomEXEreBTepb+JJlVWfn
	MHO6EI8/FzB3ylQ2NjKmlk/UzreQ+AjbyyL7v1Xqttw9d46u0BtkooSGQueeXps=
X-Google-Smtp-Source: AGHT+IH+LuJuwmspR6WLDdVMlbayW2LEANHqgFNJEOY9KQxhS5KniRy4B4R6msSK+2h63K+cXq+95Q==
X-Received: by 2002:a17:906:f58a:b0:a80:ed7e:8468 with SMTP id a640c23a62f3a-a902911617bmr307927266b.0.1726254198662;
        Fri, 13 Sep 2024 12:03:18 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:a9d6:6b62:70d5:4ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced201sm893637666b.168.2024.09.13.12.03.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2024 12:03:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
Date: Fri, 13 Sep 2024 21:03:06 +0200
Cc: Nathan Chancellor <nathan@kernel.org>,
 kees@kernel.org,
 gustavoars@kernel.org,
 mcgrof@kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B46D6F09-6F81-45B3-833F-9785BBBC146F@toblux.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X> <ZuSHB2v7OLvagZnn@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 13. Sep 2024, at 20:40, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Sep 13, 2024 at 09:46:30AM -0700, Nathan Chancellor wrote:
>> On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
>>> Add the __counted_by compiler attribute to the flexible array member
>>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>> CONFIG_FORTIFY_SOURCE.
>>>=20
>>> Increment num before adding a new param_attribute to the attrs array =
and
>>> adjust the array index accordingly. Increment num immediately after =
the
>>> first reallocation such that the reallocation for the NULL =
terminator
>>> only needs to add 1 (instead of 2) to mk->mp->num.
>>>=20
>>> Use struct_size() instead of manually calculating the size for the
>>> reallocation.
>>>=20
>>> Use krealloc_array() for the additional NULL terminator.
>=20
>>> /* Fix up all the pointers, since krealloc can move us */
>>> for (i =3D 0; i < mk->mp->num; i++)
>=20
> Shouldn't this for loop and followed by assignment also be -1:ed?

That should be fine as mk->mp->num was already incremented before the
for-loop.=

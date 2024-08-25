Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC03CF5E
	for <linux-hardening@vger.kernel.org>; Sun, 25 Aug 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724618530; cv=none; b=kbYfOOMZ+MPHgaoZK8Pk+wzFvLAN9he/drJNUOWASlO1gW9bkTCDtlG6hu7uzDgm0cMrvQEKb+RMYhh1mJczIXMnlE6rpcRVGMV/fe4HaH+l800PEHX8sQnM0+cKhgT19Qa1qTVTO3XXTy6J5yxLnLVbjcOhk+eZh1qC5NcXlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724618530; c=relaxed/simple;
	bh=r3xn1fjXtcTZl8edBo8zoh5Fcl6d/czsBH6iAELNJsM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tBeUkdaXsyazqdJLE9TW+5x2VoE2X7ce/gH5pdKhBeFsrYlGNh3n1nG/r2bKzAAd16z3R8HsQjPbrXuR88sLnxuv1J+kKg56VpynE2phcbhhdf7+Le4b81DyNb/m+/AHHoNabIiSgzaMRRZENa1XrYnjK08I52fOq5FltLm/7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=RdNqJj6G; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="RdNqJj6G"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec254f773so516263a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 25 Aug 2024 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724618527; x=1725223327; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I5eaIhTOuu7Bwecqwb9kbtmtPB9TsVLIgYezcaQD2U=;
        b=RdNqJj6G0JBBTa4j6XpgmjkWnFFYI9JJeSfEV3/aDn3l5UWD7lUgMVyWmU9EUhPTEk
         Hk6rpUNhSNAJXM6TipH1vRgZsyvLSY4p4HCp4c3PW4QDZmwj1kKP2KsP1n3rrI4QjJ84
         zdmoI/2L2euvfJeOqVPoPgRuxooFuLo3jqnblDiuvfgnys0uaRRxR/GWtdqQnv0qYbjL
         rVmiklFNZ6J1h12rHtrdHQuVCu6aolCrjzbufLvzR2z/FfcXdxkXm3gUuL3x9uhFFJ+1
         qh01b/KnnyotM5UUzf9a0w+ehWFfEXh5V5BVcbqsAdNDSf9f8ahkS/jptARJN6UlJL/r
         1L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724618527; x=1725223327;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I5eaIhTOuu7Bwecqwb9kbtmtPB9TsVLIgYezcaQD2U=;
        b=SkfyV+8GEhLfVuK7nrfFC9rT+DJ1/U3+heqtD92x6EuJkw2vaS9Oc5J/r4chDR8a76
         FD8KeS1tcRdPclHHkAxtJQHwnJW5Fwwkl3YF2JPeE8MlIJ26i5uK1Bj7BHukrgcdXPVf
         LB2ZZUaTcgW3IkOn96y0YXOIzX8RlF6rOFS8ePTUFA+Je43vWGeRXy8lo9EpmHn8A5V5
         mfb3F7MszgfEXD717nPioEg9UOoHGC2SjbT1xFblhP9i4wwqI3u+I4aFB44vWw2xqOP8
         d2necXk0uzLfF24udE2dWEZMLwV5jvMBtz2G68JTka59wtpQUiEr2fkBu0ChADDalVK1
         4/yA==
X-Forwarded-Encrypted: i=1; AJvYcCULgNzQ0Qk2jsIRljyYqr38pCjEAa7IVatXkP1ynzqFNbeGwRheQOGr+2Y6ZuntP9RmyC1UdmSiEkdEA7SKr44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDo/56bEniF+3YLWxCWutXdOT7rWyFLRJbpFfmohqv6Jd5q8SL
	Ysw4HssGZ7ZAO5hyrZooSW66h8Xw30SPQ7QNr1jVWvwr+BHOTGJVTXXwAQuEas0=
X-Google-Smtp-Source: AGHT+IGWrOtzUcJg5h8Rm7rriW5rbRJGNmxlSzv+N7+hdFaqRxfoh1QPwhLdabW+elDyhtoxJ8W/Gw==
X-Received: by 2002:a17:907:daa:b0:a80:79ff:6aa9 with SMTP id a640c23a62f3a-a86a54bbc5bmr299121066b.8.1724618527335;
        Sun, 25 Aug 2024 13:42:07 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8cae:d35d:b93e:b368])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5ffsm579976266b.177.2024.08.25.13.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2024 13:42:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] bcachefs: Annotate bch_replicas_entry_{v0,v1} with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <cqyrlfpjprkwdteljmtcnl3z2etzitvodrlv7v57tuizvklpcx@gg7dbstowwd6>
Date: Sun, 25 Aug 2024 22:41:55 +0200
Cc: Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4911B345-A37E-4FB9-9339-83029033EE4D@toblux.com>
References: <20240825133601.24036-2-thorsten.blum@toblux.com>
 <cqyrlfpjprkwdteljmtcnl3z2etzitvodrlv7v57tuizvklpcx@gg7dbstowwd6>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3776.700.51)

On 25. Aug 2024, at 20:43, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> On Sun, Aug 25, 2024 at 03:36:02PM GMT, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array members
>> devs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Increment nr_devs before adding a new device to the devs array and
>> adjust the array indexes accordingly.
> 
> The nr_devs changes are pretty gross - please add a helper for that

How about a macro in replicas_format.h like this:

#define replicas_entry_add_dev(e, d) ({
	(e)->nr_devs++;
	(e)->devs[(e)->nr_devs - 1] = (d);
})

Thanks,
Thorsten

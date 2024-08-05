Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F116B3BC
	for <linux-hardening@vger.kernel.org>; Mon,  5 Aug 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889961; cv=none; b=uMxueRf5cKlaJP4TJe3mDlfBCF1dfymX571r+mTS5TYgmKGXgw5R/MDQr7FDxlyL1YQxIoiAOacGAyQ637frkMvtHtBuqRjET6VYBMeapAKMnM6si1E03KW5PkSAICFYeo0OHR1Js5ZftWWZzGgtFgfV0c9jN8KMWplkMThSKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889961; c=relaxed/simple;
	bh=QUw3QeI7OYZ1AwcqILIHnl5Wyq/fgKZKE4y6WwkXezA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pMx7PoPX9l4bGrQ2XiuaamtzbN7QLcq6HyZBZYKm6s0ryZYM80XzZ0r31DQjzbhUIvZqO3VqsomHNNQ6gOE6UnNpMsfofRsx6pjKP7kyNW0fgfdUD0S2q1XO2/OtliMyv3phDuojGu/VK+uts0EbUa+VUZvwhqCjiOUs9fp0cBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Rc27k3lf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Rc27k3lf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso87720745e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722889959; x=1723494759; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn6Rnyxr4niEdIXil13oe5CZlyeVE53UOlfup/AAfYs=;
        b=Rc27k3lfr9eyi8SjbJcNRO/iwiEzwWl6zn+iCj+T+Hb+FzLSEHmN9WKSLekogpBZqA
         eC8/Wmp3mZI9WbXv69yFrnpm96YRm6pLvpQcCmozdXrPqAX9lXvRCGbVpXNy7NJG0N6E
         AqSSg/csyjDw0j/Rmn83oJe6Jdj5BMFeu2ESSebyh1uViAPCj/3CBn8DTaPYOE8UBTD7
         E9MMIGyFcBoWf/YCAIwSx7GQNbAZCseKFZC6ZDdCXaIoZnumAeZh5d4CeTd7OZl0izjf
         UfEUnuVs+iD7AqsDPE525KNQP6q8OZ8VVCuD895vYnWNimvm4G5DQQy0YB16D/Q9WW9i
         BcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889959; x=1723494759;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn6Rnyxr4niEdIXil13oe5CZlyeVE53UOlfup/AAfYs=;
        b=ULZei60a9pXCncqb2ch9aSka2uJSlpW0F5ZE6jzX/fg+XWkxcpiMtqYjRZXiflqcqm
         NPtWZvTIRdbWlEjeCFSnHcelIx0/JdLfMDlhgNXoj5XLVfZypQyS1hcRKuYl4DHWVk5Y
         8on3lxpYoRjf5X9V1enWryL/JxrXheL+v4+lJXaGsjVj203JgmD/EKzYicKp+XOdqGZS
         tszP+CsCYpedTf1VFbbZpYeQKAQaP/wusEYQwv1DJ/ckC7O/u92Y5RYW9KGVQkqRDv2O
         ujTgbnoArzu/00mqgfSo7Iy3/yRVNYktFUlY9OSAjTB9tzUf4Oe3ND25V0EHgdcB+Tvt
         ZUuA==
X-Forwarded-Encrypted: i=1; AJvYcCWx99dFqBu12v65bncUnzlrLLW7YLJvA+8RLAWIEmS9SxnUFbQ+pNPTCInEyL1qCssMH+JIA6Ao473ykbLioDC4G/4HolB3z5EIQmMiDrPM
X-Gm-Message-State: AOJu0Yy/Eev++GdFfyj4Nkxc7VrfjIAjOHFMXCTe1qFJsjqKcgfOIyWR
	WgZfy90mBxhusDVfTlYO0DRyv6oN+2FejrnZ38nS/K1TPjeAFe2DkAt5+kcm3pM=
X-Google-Smtp-Source: AGHT+IFEVQJwp3vZXhCpDGiKBNDcqVcaDTiD72/DHGQk9xC8MVyvZWQq5QLSREYXMf2KASU8Tj4CmQ==
X-Received: by 2002:a05:600c:4588:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-428e6b2f14emr118747665e9.20.1722889958397;
        Mon, 05 Aug 2024 13:32:38 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:ad5e:c962:d96f:7752])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa7bsm216173985e9.5.2024.08.05.13.32.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2024 13:32:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] crypto: chacha20poly1305 - Annotate struct chachapoly_ctx
 with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240805175932.GB1564@sol.localdomain>
Date: Mon, 5 Aug 2024 22:32:26 +0200
Cc: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 kees@kernel.org,
 gustavoars@kernel.org,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA00621C-305F-4126-8D04-9F6D86E959D1@toblux.com>
References: <20240805175237.63098-2-thorsten.blum@toblux.com>
 <20240805175932.GB1564@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 5. Aug 2024, at 19:59, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Aug 05, 2024 at 07:52:38PM +0200, Thorsten Blum wrote:
>> struct poly_req {
>> @@ -611,8 +611,8 @@ static int chachapoly_create(struct =
crypto_template *tmpl, struct rtattr **tb,
>>       poly->base.cra_priority) / 2;
>> inst->alg.base.cra_blocksize =3D 1;
>> inst->alg.base.cra_alignmask =3D chacha->base.cra_alignmask;
>> - inst->alg.base.cra_ctxsize =3D sizeof(struct chachapoly_ctx) +
>> -     ctx->saltlen;
>> + inst->alg.base.cra_ctxsize =3D struct_size_t(struct chachapoly_ctx, =
salt,
>> +   ctx->saltlen);
>=20
> What was wrong with the more straightforward code it had before?

There's nothing wrong with it, but I find using the helper macro
struct_size_t() more straightforward. It's just a refactoring; happy to
take it out if there's a preference for the open coded version.

Thanks,
Thorsten=

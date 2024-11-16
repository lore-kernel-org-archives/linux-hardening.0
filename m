Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD580603
	for <linux-hardening@vger.kernel.org>; Sat, 16 Nov 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771632; cv=none; b=aMlebKRArj09WeFpqV2e0AsUa7LyekEgITCkxLvMr7NRQKd+twiwG0ZzA3A5e2W8u/Wsjo1rgTEF73I0QMwvuQWjxIBryvIUsgYR0/f8jsVPuvvWEDE3nll/RxS7tvENtezH6XzODZ9mKD9cBD5hFOPXoqrRT9zybL1dhDQDCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771632; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=H2yxgdBzyPGN62fG1pV3y9Af0YtWywMx43E9n/VtxUPjT+JaFoQvMt6SalZjvItmZD1w87RkyJ9Zgzo5zHXBECMbYq7EfAJDW8K4vdGghE/XImOPgqtoxL4I3HPiH2/xVHPpDzXIVmzvjYfw7UHYHVkOs7b/rW++alcUmmZ9pyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxJz0Y8V; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxJz0Y8V"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so553940a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 16 Nov 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771629; x=1732376429; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=KxJz0Y8VeORnx68fdPkWkjKbbKG6gXfSn3AnNlj2zYc+mHOlhEtseiga1cCl72fUB6
         jH1yUNow6HkxedbT9kT2G0F6r8xWHztQk6YkbuwM5pHh/8zuSkIU/2klwAb2jmpIEJ4t
         yF9ha3aK49yi86hyf4HpdKBvoz1TMalErKgox5bABy9fNiAAxpw8oZeGTdVkITk43euC
         w+UkWUsxcX0SW1C/vWvGY/R4Mh6xyNRSWlXZ4Wa6T9VqubQHhoHQdoBXY/tJfcx6BtkU
         s8nnfMeqI0LcOPmhhxV9hllKOOVuMaB9Aq/MMsrOSDXT9/PdwVZiHbxZV0cCUrFOPsNn
         i3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771629; x=1732376429;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=AEPZkP6FExuVQn/zXKlQr0gK223FK2aoO3L5m2jnXnA4dJIjjfwrUhezG2HLQB2Owj
         wXg6uq8kVIc0k0aHB3TUv9h6K+8GN87qCjvHApVKJqWLsHGdsaiqBIBS1jZLh6d6EfD3
         29HjL4NwDKZRq3WMWbi3Er1hF7S4VCHTjWarkPBeWXdgZkK1azanbzTo/r7tcLhDxVRq
         vcJVFci0INVifwb3ZL5C3mX2GTRDD2vWLrYJZbr5wRukTrZqWZdrFqXw904i6oY43SCR
         5ZkZlTn4qu1DBksyT5z9YGTFhxIcDT8bnyos0UMRF2UXthvQ8TtokhyUC0PV/6ntdqR4
         C50A==
X-Gm-Message-State: AOJu0YxFGdBEDRKN79dwJcG6EgaZ6zU+GT1SmGtB8LK+57WWmfnVIxQ8
	Pdt8e9pI6ZJQ1AxXFmgFiCItN88g80YUZmLCGuLBg6h5eUnGPzNbinAvyQ==
X-Google-Smtp-Source: AGHT+IFMToA4Dki2BpqJVVc+E3oZWg08TJOOzBaKmsszV6ZlJuDTxLxaVvSEr67SA6kpKsJ5nbzfag==
X-Received: by 2002:a17:903:22ca:b0:20c:d1ec:ad5 with SMTP id d9443c01a7336-211d0efaed5mr66044645ad.51.1731771629232;
        Sat, 16 Nov 2024 07:40:29 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771fc665sm3168268b3a.173.2024.11.16.07.40.28
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:28 -0800 (PST)
From: "Van. HR" <abdulpaish4@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <0adf78ff24f8074c89daac667ce89dbe09645c06f891952d48b407ebd2727246@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-hardening@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:26 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


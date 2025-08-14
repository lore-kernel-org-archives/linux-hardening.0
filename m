Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5A1A5B8D;
	Thu, 14 Aug 2025 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191553; cv=none; b=ZV8uRmuzdGmN60qRNBUNXjeWTycIq7trpoMW8gfMtfeVhSiqWd9EP+VD3+Imh+Uuf/+65JYcyfPQW6p3eOYdY0HRIWlEIGUeipDIvmo7ZXntRUz1H47mQmGWkA1qZ7R7Auh9cmnfnF8+UyxLl8Kaj3UOZRI/JAqwD8aypddJylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191553; c=relaxed/simple;
	bh=NUhEd/hr9mjGYOTM3SXEewm4f4ZHIQ5SavCdTAnT7tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qogZlfZ0rK0dgGScJKwU3pBdlY1bHo+Sd8rwDc3PLZodHia8mwOw4vj//u/+t8Bb6F5C60BmYrej0YNwyVYRx/9jIzjZziqtU4MLYcQ1h5buIoESzw15G0mrFYLuHrfGPeJSUUqQXxds+2qlEFDlN464Fwg9l+6AwVwxnfW0ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkoaFs7M; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkoaFs7M"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso1542154b3a.3;
        Thu, 14 Aug 2025 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755191551; x=1755796351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUhEd/hr9mjGYOTM3SXEewm4f4ZHIQ5SavCdTAnT7tY=;
        b=AkoaFs7MrpY9Szo6hxEfd8VrKL7Y5XYj/EDROQhRX0EUq28pQ6t3rdY86wlg0Wpg88
         v93/D7k8c2XfY4VYADaJns+Md/sjl0OJ8DHDcpS55uUXqe9ADeXDh4Z5jOQE9ph1037e
         7Z2OnS1K24rr/NncuA+JzJzALePylsXDSh05djneptjYjt8JhFUx/6V4Rm6MN0Jt87BF
         T+mazAEIG4e8vCw+qWyQrY1XBpWePzP9cpNlcAdyUdXfdwMQX2U1nw8J24okYk31fdmd
         WrBtYn0fy2nIbQ++qSzAe6sFbxw/vYOiODHIA6ys5F3m5XTIoFtl3l8EqkncUWbBKeBW
         UNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191551; x=1755796351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUhEd/hr9mjGYOTM3SXEewm4f4ZHIQ5SavCdTAnT7tY=;
        b=QV0N7nAiwrSMKzzG0YoXL0TB9daGSybOyMxYxipB9a2Np4YLe9dXU8UpDf+KSo9VO3
         KkVWgOr1bZpamSja0oywY2SjhhfJ8TGfCXOSyjgrUWv/vVaueJmhVz3eLJCeWyqOOyEh
         sIDYmPQw6wwvYFK4kZIH7BTu3qReViQ0YoXI0qQPoOxCwaE2O552qBVpGWKM5huwvcYK
         7PZxXKlbVCC+7yIzLxjWwlLcChHGYXVvccJY6on4WqTEHoKQkKx/betFr+21vZQutTXm
         /Dr7g1ggnQ+RgnYwS4wb0DEgdCIbslBE9mLJziRCHNfDm4mGa/KX4ahhPFQmoFUmisDU
         WIIA==
X-Forwarded-Encrypted: i=1; AJvYcCUBv9Yz6UIDLu74UxVY1BEJdw2vd4wFiYtlzv+0aDoaAXRoWF9zGM37CqJGmoxyeTaO1oyZrHOg7hU7oWjQs/o=@vger.kernel.org, AJvYcCX+EPqJp1sDBog9I+CkLQ/HOaHv6rDqNZNbXWJ1VAHJV5YvWLiFQ3zDyoECmjm0eJR974hZyJS+QnpH9I07@vger.kernel.org, AJvYcCXLQ/omm9Mum6PQyoRwKWIkJMsO+49TgdXlfxWYluZ9m1cmOu70Ct2m6ti1WtLJGnRU/4QMN/gJgDPK2qLaEuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39oa/UBQrZKSgx+VG935riaRPDmQcSCcT+EKjZpRcm41Bj6Ct
	eraoyRIrtbi6HI5tXkln5yGl8yHWHcR5QEVwC5kE48Z+Nx1hEnPpM3n2
X-Gm-Gg: ASbGnctU+mwwnCFU1theMFcBLl00e0OeCVWvwZYWCkpfvo94JkJeGlov8mTmXyOjLy6
	TpiGUIAHtXU75KEaV8wJP1oiM1iOFZDe2B9nlk3TTcC+s/yNNxxx5GFVoctUS8K3hC8FbqSEuph
	JJ/ZlZChMWciQ9luBecKCOMPvuRIa9ELZRHbPKSntW8f2A/kBFsASx1ynB+rJN/Ga6zH2bnYKbV
	RJr/msbNjbdZagcZFls8ESWIg0NU8qdUiu31P1HuZpxDfYsq3RoduY9d+/kJd1OdS5YnjZeq3wd
	+4iSJWpXORJZrzpnxRCunuHEsc8n865Y/DP5bDfYuG/KK9fwgkSx72I97adtrv0fqk8I06xOxhf
	6ke90DteUH6iDwnaF51366A==
X-Google-Smtp-Source: AGHT+IGKy0kpAa1YPp3hGMo3FDMKqoz4yKQcO5bK6ZQE3fgZytiMSqcFhtnCiE3xrx4GIxxJpe4aOw==
X-Received: by 2002:a05:6a20:7289:b0:23f:facd:5bc5 with SMTP id adf61e73a8af0-240bd23b5b9mr6528222637.25.1755191551460;
        Thu, 14 Aug 2025 10:12:31 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e1b99ff8asm5921303b3a.57.2025.08.14.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:12:30 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:12:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aJ4Y_DAZe__0EWEm@yury>
References: <20250813153548.1650533-1-bqe@google.com>
 <aJ2Y21Yjs3a0CnAo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ2Y21Yjs3a0CnAo@google.com>

> Thanks a lot for doing this, Burak! I gave it a spin locally on
> v6.17-rc1, and it seems to work.

Does this mean Tested-by?

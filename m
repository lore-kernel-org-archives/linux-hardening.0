Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CDB305E2C;
	Thu,  4 Sep 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008970; cv=none; b=e34puenMos1gpEZwtLy4FiZ0tc1BKqmfq0DRRrHYAhBlgnhgSEAeq9NbOAxMbAHE0Jovmdwc1Z9mEDkchxseJJSCOpxxuByJ1htGvd6MvqdGg1VayXKqPeoPnjEpOiEu3C51MOpKjFgVsf4TuWwCEBRHPgEMhLYkBSPRKeHJPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008970; c=relaxed/simple;
	bh=9m2+Knp456ZCEyzvARIpHs11Vo3J1om399jUM7dRa3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtOGK2OrMk8DJkTR3PzumXF70+kLKYgtwgVfmHxxTEf7tedUcq7fxy4lhfY88n/6HdYw88KwCA3YVIwofllF+2R6Qxqd0FWDrgrZ/ORhqiiiNBtzT09Ao+3Spu6JUKSm6H/eUlEvZeDtGqvd3bzQxlU/u97xjDlSbrpQZTTRs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWyi0H/B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWyi0H/B"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c786130feso12746125ad.2;
        Thu, 04 Sep 2025 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757008969; x=1757613769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9m2+Knp456ZCEyzvARIpHs11Vo3J1om399jUM7dRa3A=;
        b=EWyi0H/Bq6BabMFY83+/juvp4AimcmG/QjAADlLubz15ECNNXZynk98w6RgETUAPc5
         8C6o+G9BzvuH7mWiQTmq6DrtvvMAEUc9FrWuNhSNXkwHqyiU2yGQPH+fPzSp5TacqScT
         boXRjotu4f4PwlSL5wA7UEl1jndWAhRvRZD/G5qQdX56hAGxDhVUk+YSvRTxJrl91QDv
         Fcc8zzQlECdkNGiNipkGXwP8Y7iNmwts7dQiW8EnGcpPgBE2G5RzQCav4cWgv0tFPuBW
         CP/O+UAlgx84S/t4uPYk/BHe/h8y7nFxQPn9oO3xqIf28hY8T0BMHBakpXcEvwKgghgt
         5VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008969; x=1757613769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m2+Knp456ZCEyzvARIpHs11Vo3J1om399jUM7dRa3A=;
        b=sAzwtzG7lRq2stJzzJsA0FRUvhZHDg/0AQI0pmBuBUlErm0vsWuTNlwToY7EsSLDBW
         iRAgi+8lDRJnOIWr+gQZkC2aUjUXtK0AgoEh6qmf4H1CVzMkKTpH0WB7NdC8x3F7nt3o
         6Kvwsj2SlhW84SDnkrslenNOmnRog7VCFgbxlKcxOcc8VBBYds6ZXOcKjQnXJNlk8QJH
         YdHO2z+hfoS+0cAoD1Xe5dwbfk0nZ9TmnviMRH2odanjFRwUb17IYBvHC6zVk5PlFuzd
         zzoIe/sdVpdnjIS8q8L4xN4taqeUVJO+Gwa2D50edD5HZupx4Kqzx5lgsjZOQ4AjnIox
         rq0A==
X-Forwarded-Encrypted: i=1; AJvYcCUPNHKETYSMEck+QZ7w4jllGrDi+c3MqANJao2QaKYBIK9AdlnKI36CsG56i3kefBBwtCzcqZt3dVy8cOYc@vger.kernel.org, AJvYcCW2bTyVlfpZtWd2zZz3cad+YYIDlTA9b+9Zu8dSumB0A+I0ir8dDqUjJgwRKw1vDYm8B2coB6ocYVv68xkCfY4=@vger.kernel.org, AJvYcCX6au/nIU6b4pEJB0YYdJd0Am7m7GclztTvAX6tm6KCtXecCnbQNKBc+e9KOsApVT+esLqE3CAV1yyHFfddl+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSnQleaBrViV/gYMegagvvjUtiSW3xBv+5fQ+9l3okvVGsdmT
	ycJCx1WFUMMJnxL5dco0iiBZDSs3tYuwHwdmtI//zC5RcQnjFy3vp/0Z
X-Gm-Gg: ASbGncv4kjOmw77w5uRB9VhHhZfRUM702FabiaETHCLWc0MCyl8VG/vZISELC1pt7rW
	xWby8nrS2DfAenCguNO+Sl+u6Vyqx0C7/EZ2mfgG7c7e/2sx96dl2He0UvIr4fm9lKN96vl1ozB
	U1VacRcDRWVy5T3Zt/grPwPQMlJYmwq/Rv7vUbj30tY7px5GWWCFN8rnb0LQ+auC7sf/Nl9lEjk
	qunZjPFh4zLt1gQBrTHMpqKH3zWZkF1Ro2dVuvKXiOCFS3zj1b5Hbjk/nPMO4bG7A8tVQLSR5m8
	4OgH+bJDquBb96Yc35v7+2U9snfDhm+ATUIMWCVNUjdof/Ln1NX+VMpCEkFvpeRaDrR2zy0BhD8
	OJU/mVckPPj1QT+Bk6GkSpvYZXQmV1xxPQbT1Johh3Us=
X-Google-Smtp-Source: AGHT+IFt1YdwQYa6uf0UKpSYSWeB0rrSwFVcSYr7JUSX1VqIFL6DRixZ0NE42ePMXBIA1aWC7I59Wg==
X-Received: by 2002:a17:903:283:b0:24c:e6a6:9e42 with SMTP id d9443c01a7336-24ce6a6b740mr14589495ad.27.1757008968372;
        Thu, 04 Sep 2025 11:02:48 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm89280895ad.115.2025.09.04.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:02:47 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:02:45 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aLnURXW_ZiX2iJd_@yury>
References: <20250904165015.3791895-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904165015.3791895-1-bqe@google.com>

On Thu, Sep 04, 2025 at 04:50:04PM +0000, Burak Emir wrote:
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.

Added in bitmap-for-next for testing. Thanks!

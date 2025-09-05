Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690631D744;
	Fri,  5 Sep 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087789; cv=none; b=q7Wl8flukJNTAwmwl13+kiAuewhbNcOj4j4o5INbkMMAcKffayJIfOzR1hy9ZwyUDJ8aUc0Gz9gTR0BMgnXPtV0wuw/Hn7rEnRHT8WZ+TsffXcOdWKwWGozoKOndMa/dkJxFuM6p3uCcrA8bBVxNS37Wd21+tlerTBRXBeOlNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087789; c=relaxed/simple;
	bh=pcnGAznxIEC7EbbTSRq9hisXNulVSJI/mitRD7IVHy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puLO07mTWRp+QIPNWU85y/YxYY8ArMQsum8ohHXOVqK0zVZ5WvOQ6FfTU3g4DWKh7oHmbY91HijSKwjw8VmfW/sDlcWI61q3CiKJdnovrI7s4qEM7JOPhTREb9tQ8DvIxGVDlQSBRWA+1c+TGqTU3tfgsm+1gA2lOU9WIdRTRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8bd3MXp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8bd3MXp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-248f2da72edso3788025ad.2;
        Fri, 05 Sep 2025 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757087788; x=1757692588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcnGAznxIEC7EbbTSRq9hisXNulVSJI/mitRD7IVHy8=;
        b=c8bd3MXp41TfJYLnPWn9Cix75k3aPXFJhU618XW7lb6e2tOTk42Vvvp8zVdLiI75fR
         YqIBtX69g8S1MstlJMHAACT1QhTQh14OqH4NYIY4HIH0gJBMlqsqsjWixxHDk6XXyl0D
         s1ME0cl+BSZZXtMY04jxDTAKmOBKHXln/HnNYRrSKG7bJxqVwqAdCA7KhoR1C2vgM6IQ
         7ON9PiYtKGF+/tsSGRI6u2GFe3Gydabd5vtxH8QpD3s6RfFCrjgBHzw32pONKBQ7VTmX
         UMT85yYoej/u1cN4RrbMdDMhdINktREH7L7tBXjR4M9F4r7Dc2h+FHA+1KNVe3lWdbdK
         5QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087788; x=1757692588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcnGAznxIEC7EbbTSRq9hisXNulVSJI/mitRD7IVHy8=;
        b=DGz6kI7kdNmUokQXMcZ6of1iLAkImLwafqlA79+TxwLlSyi/3/d5xHl1qaxFMLUlhR
         JgXG8VJelKcZl4bqBVgsH4jwmPzIWHHNB0kFzkXSkCS1vUApxfbb5EHFMcu6q/GboxTb
         zZ2IEB2hcqZ2WBjKDGcq5LyYoI3WQjf/vw571HlGCHuzojA9zBa1bGmOmMfPLub0tCYW
         3qgsDYVEiNmU1cpK3xa34IASRA6nHmWuOqHZ2OrLJlcp3y0GaAHH2ccMiWOSgJ2r/RhW
         lxCo6nt+j0O3yL6/afoCFHnaHe4iWyGvpcqLxPgUQvO0Qy8taumI7SCm02yZsKkvijS7
         vEGw==
X-Forwarded-Encrypted: i=1; AJvYcCWr7E6xtvZlWSVm7kvMuF80pOGP+FuF+GmlAjWo/aRDPRDM1BFRoW9iAYf+dtJiz6njw3R5IvbTVv+ybseICx8=@vger.kernel.org, AJvYcCXChb+4rrksOz9vbD2W9qh0YDHFM7UdHFUBg2UPPEpUQWJzCUvhJRIIZDtd6h4JOg3E9TudIiCyfw8bOD2H@vger.kernel.org, AJvYcCXWuisoHe2KQuhjtnFLVHcJb8HtZx7p17yQcf/PwJaWoGnqkwjPPLd2Dw1CyNCMJOhufkCNeqA25rVNnL4kjWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5DZubh/v8c2mQPVpiyccQ8/xGXLQ/GmEQn7Bb5kzRhXkEajb
	aDzda8dBhm02TbLhxbnAVlbIFeUMQmm0k4RWB1SPGeIkOAnxMfVHJUiKE2AwyeL1YSPklgZbbQd
	bdoelZdRWykvKO4E4Jvyuk/4k63M34rk=
X-Gm-Gg: ASbGncsdUdmnZQBYroQshtWI8JcmCjJYKPnSabAvFZUEBKtKGkYDbJLVfkosVkp3HYv
	VbS7Tn/yvMOCLSxwUnW4doJgliuSN56VnjutQYqYgvGuft0imNIZDf50Ynhr0vRfcitjICl9DJg
	StoZkJGyLNPF+7KYeMFsqmVQPZ2V04sHMsdso9hFrIW90NSxKNu8ZcDg3h+XcCEBZrOkFtSIZyX
	BbGgaDtW2+8xOwq6ihdFpvUlYvABsbnYCPN2SPLX1G6GbOegt2Yfn9Rnouia0z+hJDOL2HsjvH4
	krDU/WSBF3hmuLRMLeodGi1vGw==
X-Google-Smtp-Source: AGHT+IF1dTaVV6W/81i45DpyYdcg7pg29RYnQDdjqqMS3Pt5h19w21OosjVbZcjDakD7XmGMBIvdb/mrHGnHA4PtyM0=
X-Received: by 2002:a17:902:e74f:b0:246:ed8f:c63e with SMTP id
 d9443c01a7336-2491be7d2a2mr202503665ad.0.1757087787736; Fri, 05 Sep 2025
 08:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com> <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com> <aLrjNze2_L_vAnWX@yury>
In-Reply-To: <aLrjNze2_L_vAnWX@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Sep 2025 17:56:15 +0200
X-Gm-Features: Ac12FXyBrmRcLFt5YG2uxmiZLky5ex7OPkFK9lSHgX0FSU_aqENr8sCbxJ66nnQ
Message-ID: <CANiq72=KyX39_jyZNewithy-bVL90wN2mg=SQokX3ArKF83B6w@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury ooNorov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:18=E2=80=AFPM Yury ooNorov <yury.norov@gmail.com> =
wrote:
>
> Thanks for the testing, Miguel! I've folded-in your fix and added
> your co-developed-by tag. Please let me know if it doesn't work for
> you.

You're welcome! I regularly build a bunch of arches/configs/compiler
versions etc.

As for the tag, you are too kind :) It is such a small thing that I
feel it may look like it diminishes the work from Burak and others, so
I think it may be best to drop it (and anyway I didn't take a close
look at the code or the latest versions, and a SoB would need to be
added either way).

Thanks!

Cheers,
Miguel

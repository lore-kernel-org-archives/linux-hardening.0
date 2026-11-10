Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281967;
	b=E8maSU6PDf3Yl6eoFquj8HzE3vsTw7ostAgpcDGZfDMgNvD5OAkosbgwJJKhENviPNam
	 vU8zj6SFmj6yWZ2yV2S1q0EYnVSxrbJBt/9Pr40re5KlRQbZcegS5CKIeTbZfh4sY47he
	 aCxNUklokJswpRir7ur3v3mEt3CnQJLtcE6B4n9plgwIQVV/Cu/CaHQ8c6PUvbZbLzvBk
	 bAD60h29f+BnvHuloWwYW/yJ/N/RZ0UZf1mRYsnQkat+/KI8sn4El3FXGbphDMTUwIHJz
	 EA1Ixtq8W1uITGtp1HB98mxSaF3YEFwFfuNKCMsxmtL/1BJBUnUsOtYzFzmQh3F0DvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281967;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y+1lY4bhPUECLFQkJKPsCV8cDSPAAPLwsf+L7+iY1Dw=;
	b=qgEAkFDgdnai2RE03SGrFaKzzXNqfZiJPArp3msrfgqrYETMI5jytkWSP/33dgFPpM5h
	 ZdlG3spoaPkcxlKSq8d+KZLJtixO6KxNJpl5W68IBYVT9yZw2iIerYQbOp5ZGjZqLS2T2
	 59mLwK1Yp0jqw7Z0sd9MOoFGQo4zM/f9sx5Wpgi4m0QZL4nSAgbUS45GmQGVegV753045
	 8JitJtjcyoot7b4awIZ1DLcljS0tx9CGocuUrYBee8kjzgTUaTBBDPwSpLKu/MjVWQpnI
	 5GHJitB328lPNBknn8pESmEg7sITMNrlIbmUgJlWt1cxPffzWRhbvKWDzPchTFsShOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=EDpO4EKA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0B606AA0A;
	Tue, 10 Nov 2026 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=EDpO4EKA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3FF1F0089F;
	Tue, 10 Nov 2026 03:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794281966;
	bh=Y+1lY4bhPUECLFQkJKPsCV8cDSPAAPLwsf+L7+iY1Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EDpO4EKAVVq1Z4V+/KSCvRx6YnX8ClzkdTVPEhf9aQNgEoWeMI/kAO0qulljQUGaU
	 1k+vPrnc3EGFUM0BbzFRBiDnxT5wAVDgu5rsixPh/094bBFwj8dHJAsax8qyz6gLVH
	 AepvD9Q6EhZUeRrvMmyF2c+v+QnW5UC97J9ApTMg=
Date: Mon, 9 Nov 2026 19:39:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, David Laight <david.laight.linux@gmail.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook
 <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7] kunit: memcpy: Add benchmark
Message-Id: <20261109193925.8a127f2d0afd5429f1f551f1@linux-foundation.org>
In-Reply-To: <20261110021622.122490-1-technoboy85@gmail.com>
References: <20261110021622.122490-1-technoboy85@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 03:16:22 +0100 Matteo Croce <technoboy85@gmail.com> wrote:

> Add optional benchmarks for memcpy() and memmove(), enabled with
> CONFIG_MEMCPY_KUNIT_BENCHMARK.

hm, sorry, I must ask "why".  Nowadays optimizing memcpy() is a
super-specialized thing undertaken by the bravest architecture
specialists who are unlikely to rely upon a generic kunit test for the
purpose!

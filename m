Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348445;
	b=5WWdw1Qupa41384Hv6+5JidnjHTIxF9HyUGnRqJNCTtWjvhcx+pXus9yftZjJgySf0CH
	 BOHoDEQHc50FE2yWmc3dg6AfMMKjUlSnJiZICWlD0WgHNJFT+Ugu8J5knddVdgZarxkyr
	 wBLIANsVWMyVm6NlUoyyszfJvLsPdU0Snl3+QYlBCNKiEgLjEF66q/ymJhohjwNwL4JIL
	 NUg9QXF6B4n4x17iL8Hps5pd0gwL7Ltuqxk76cYlDWT79sQvctIhT7iT5tOeFSipQiDTa
	 LmWznYj2GEdupULo75x36BxfbhPbKL8iqBPk9FGJ2pM7XThZ1AfwLDeQp5kDC29ozFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348445;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5MDBIforooY1sD9AtTKqg6zWiNRLvMr/UhGBWOP2DnA=;
	b=R+Iabl1NZeuGDIrIWTrhOjRvKYMUBnz9pEm0XQRQHhmThNV3K008Bu/lWMn9f7KNab2n
	 q3v1N9b9q0bl3FFaXoGZmEArWChpkW47hPQTffR/sJUspKdZrWDnVBFcVsjXT0o/2X3At
	 crH7cPvOkYpoIX3D/SbEEyxG5OU+WpdJxZ1wMSy9aiahFAfUnduylTqET8j/oIGPMV7vT
	 P0TcYKdkZOPVlZgPfpaqtf4bRjflAkJtp7Ye0inlR9WdcQ3DCz4XU318zuvJcfRrFcguP
	 2zISpU4nC/qW0dX4gc1piapfueo/I/PybUpvKmDLv+lD84h7nyQradQMDcrFmEBIb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6Sj1TZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3E606A330;
	Tue, 10 Nov 2026 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6Sj1TZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ACA1F008A1;
	Tue, 10 Nov 2026 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348444;
	bh=5MDBIforooY1sD9AtTKqg6zWiNRLvMr/UhGBWOP2DnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X6Sj1TZBNCQpK2BgHowT0qIhULHJNWYaH9lBO8mw3n29wuzqFHT7o6pN0r1oLMxeV
	 fvTfOCzgXIp0TdpVMrQsPxYQ6heh2WEGc85TyogIAfAdh27HVTN+Ljm4Yye9GOufIB
	 DhwacuRfEgLOUF2QabPg3lQyAy3xbCivhTCZNC13DEDFKPYKzzyBRpfDVPATzGATiU
	 3lJ0/s6mXzoxZDzPksWQvjXJXAOkuq6Lx00uQogtlMjl4QppbQR1KVwXs5vJMFDFWN
	 gRbT5lOYb9IVvZjcSrpeYBmFWPr/rISpB/dFodCrWT0WD4EcMLV9am4VNKSc6l6twm
	 XBAkPsNI5TPLQ==
Date: Tue, 10 Nov 2026 14:07:24 -0800
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <20261110220716.37bfac-kees@kernel.org>
References: <20261104033110.out.418-kees@kernel.org>
 <ausWlN1oWc0Utnxb@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausWlN1oWc0Utnxb@devuan>

On Wed, Nov 04, 2026 at 12:28:27PM +0100, Alejandro Colomar wrote:
> Please include:
>
> Cc: Alejandro Colomar <alx@kernel.org>
> (or perhaps a second Reported-by.)

You were Cc'd. :) I try to avoid explicitly listing CCs in patch bodies,
though I don't always manage to wrangle "git send-email" correctly.

-Kees

-- 
Kees Cook

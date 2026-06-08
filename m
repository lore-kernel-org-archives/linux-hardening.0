Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D62395ACC;
	Mon,  8 Jun 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950193; cv=none; b=mpd7vcFpDDIDGbNQ+qMoDHeQySaEPmkC/Gi1LRWT+LAkqZOvkkHVEFyEjxys6AljT2Q7xt51lYi3yv1pe84vZDQnMri0uj/wmtDsGeSSR9eLX7yXXTGJUUmSV/arBfts7dp1ILSjf34xr24fSbfrLyVsnM3ctNzgeZiRW2ktAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950193; c=relaxed/simple;
	bh=u/YixolN/omv2pWdakzcVtVtr1tfN9sEAovCRRcAlwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vq+AAx8mOiOytum3BuxLV5rYOWgBIY2P5CsjTitsnOQVMB3Y8t0eTehw3TxU640sIGLH0RQ2Rt3Vhgqa6zlucpCqaOnCstQbwaCaHEl8wGkOmRViXKECTnZ6zOJFYGHuWfMwfBP3Hy0xyIk0yjHviFl9E7kBJccd1u8o6bZj3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgobNyY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgobNyY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46061F00893;
	Mon,  8 Jun 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950192;
	bh=gyxEzpk+o/BtLnmr0Qtg+nkW9g+mrMAFqzAbu4+GYMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KgobNyY26cOj98y2qat8uqukeyogN5BOwTrzN6rrZBWZxNNJCr22GvF2GwITA7K0A
	 0x5Em21F0p18o02047Ith3jTTbOApTXKJcv2KIDVPr6rUQUTlcshSZWIRlrqiP4Klx
	 zPccdK1mTot93klyADWjqElNL8uERKN/S1wYtNDAhx1sMYSMBfzZq1YY8AAXwxPE+h
	 /wm0U0AS9eOHzXjs1Mg+DS5bkw1M9zJF3yZhsIqxuPHHx1TwbjdJsP0mO4hckLNOHD
	 lYCklE5OgwmVtRW8+fZ9ZTjFwFWji7JbTd3wKj1qRoZJGWtWevyoHJ2R8U8adxKqBU
	 2cQrcq0yNFC6w==
Date: Mon, 8 Jun 2026 13:23:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608132311.0fb69fed@kernel.org>
In-Reply-To: <20260606202633.5018-13-david.laight.linux@gmail.com>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>

Could you be so very kind to read the automated message you received
when you posted this?

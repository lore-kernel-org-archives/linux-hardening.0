Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908880;
	b=Xu6Tnf9nhva0rEMhHDM6KBHkkEI6ReeaxHBzNsx503guTL8YKwei1FkSFVOhihM8BzcB
	 QLfw5VQBKLNSCmiKC9hcbtGZx4h74WdEb4rFQZfstMEhKyVZ2DpR6yH9y+bKPpi0Bmeoo
	 EvJiMsxHMtwJYNNd2RB3LFmokeEK0SiroVglyVxIq2qGvJIq71LUWJtNPvFaHu4H5TfCa
	 6akAPpESijk2qG8MocwccfhW5ZjbWR71C4BoYui0xCi40pv1Q5f+93gA1nDpfgJZYod1k
	 gHxQ9aLZwyzQ2Efcfz2APItnrbHUzJIBtFfUdnwLZwiiJnK99b2E+QyWV8Y2zEoY83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908880;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tBS5ybMVceqsdB3AuvlDE6Pz9BN9C85Ik5aKc/DxL34=;
	b=Ry9nLjYqYypYJgcljBRvIFXvfwdobciAo3l5ELPE+8PQjk+64gOYs/3lPl9yWtoQoXCL
	 FlVnxVEC6bD+V8WdvyQesHP4SjAQJxZGfMpweBN5Cn9tyyAFXIhFJvQ7MoF6BuMImBC24
	 EaPSzBrj77Cks4KwPGWEyPJDaog09k61zEFL5yNsiSvt5Anh74UYsZe/+jm5BOJv48yx8
	 7hK/DvhKGU/erBPrZHcsxrWr5QuakDa3sX0MC0I5ePJJmvbMIwpoSEjVuktsze59XfkXS
	 32JQ2zb95zIIWvG/NUjQ/9Ng6Skz9Od3aAlhxZTAjeUm8ucsmg2LD00BaF1hhP8VcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="grt/fCor";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 28D8D606A883;
	Tue, 17 Nov 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grt/fCor
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5558F1F000C7;
	Tue, 17 Nov 2026 09:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908880;
	bh=tBS5ybMVceqsdB3AuvlDE6Pz9BN9C85Ik5aKc/DxL34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=grt/fCoriUsPIrwJTIh/oDY/eWpDc+lFLFYWIsNDxXJM1xM4lElaZA7fROH+oDkhK
	 2HxygUg7new3LNji3VYGuIiwsOwba2X8FHrWvE4TQHSVVYFWYeiz4PNs++KLW3tsjZ
	 EKQF3rZikRtd8vUMTSwWfvVrMniscwxcZvO/SlgyfOFzFMQ3e4wEAGNCse5meMPR2C
	 RMBouZS3t/YeTj0XxRP37faYvZ7WlhyvsDtaJTUUu7ohd9sEU+Q4QPTBqrGkD5GV+r
	 VfaqM62brikFylKVDtKrWDdf+5P9lbpsUhlqiC+UJCAGBoARvDljDMphzddjg/CjF7
	 e9m2pH/b9ktvQ==
Date: Tue, 17 Nov 2026 10:47:57 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 04/10] device property: provide
 fwnode_property_get_names()
Message-ID: <juvzhitutqsxyngrmxekmuh7foonwsqwksbwxvcubo57o6sbzg@zyo2zoxqkr5u>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-4-4edc23d5cf50@oss.qualcomm.com>
 <avc3PNEMESd3ewBh@ashevche-desk.local>
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
In-Reply-To: <avc3PNEMESd3ewBh@ashevche-desk.local>

On Fri, Nov 13, 2026 at 06:13:48PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 13, 2026 at 04:47:04PM +0100, Bartosz Golaszewski wrote:
> > Provide fwnode_property_get_names() - a new fwnode function that allows
> > callers to retrieve the list of all properties of given firmware node.
> 
> I don't understand why we have this patch separated from previous one?
>

One defines the fwnode operation - extends the fwnode interface. The
second adds the helper that uses it, which is not necessarily limited to
only calling the new callback - as is the case here.

I'd prefer to keep these changes separate.

Bart

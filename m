Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E2312832;
	Sun, 10 May 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778405385; cv=none; b=EU97Tz49sdvSdv05vTWhsjq+kRVmJMVRRrViGb6QU2YTqn3Opuk2xl6WUaF4pqmQQPlNGENFQ/a1KZLcK72Gz51wI3gR1jnidTIvm8M/XgH1VqgTB8AIbt2OP4MgUKb/DhB/+5V6qqOAMlfaZXpbJYm3rpvVAHOV8iUgpcXVMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778405385; c=relaxed/simple;
	bh=cKVMSTFh8j47BhB7aTfDm3VNCYei8y9iNADNqJpw/Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaJ4b2StD+CsYz1DrD6Fc19LOpS7mwGryEe0sRIncpOzFn5/8Etni3r5Eq1I9GCyJLfR4lxNJpOCEq6eILN3u1MaM/x34oS1wOavQzYM92qcorG3gB8WegsUMQIqx6/VZDjht0FbLZhOPP7xL/jmGybeu1fHtpI4lFSzjjzlCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Rco1cOnv; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Rco1cOnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1778405380; x=1779010180; i=wahrenst@gmx.net;
	bh=3OUgryxBv/IofxM7RjR0BpQfLW6haYqHqpI0t+hcCAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rco1cOnvwGByKqEMpoBQe7Wkm1tpUdkS+vzS1aWlNkAoMPSnSB3w+KCPE5DPhEgy
	 RsPRnmenXymeMnQUL7H/k12RwrFdHqMJXI5OvnIC42UIkWtdYlNpD+ch0qyVhqSEA
	 A6ogPL5ACYRV5nq5C3kunD/vKp2ipUJ8gQ3mGkPzQtNdr3F/a2IKSsoctLAimwRMF
	 cQO6RcqBATKbIEchAyYTqtypqyZjioM0FwkJQq0CFCXBiecsN8wuPLFqa7PF+M9jg
	 oNEfTpTj3WxesOIvA44dyLoREHDmGUhFBHf75H0GYKybk7O9qUKJD/cOHyDQYLjpx
	 hX8b+s7eKPTi0EPK3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1wpgSG1Lo4-00LA8J; Sun, 10
 May 2026 11:29:40 +0200
Message-ID: <4c54c010-fc54-4d56-bac4-8489e0db82db@gmx.net>
Date: Sun, 10 May 2026 11:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] arm64: dts: broadcom: bcm2712: add
 raspberrypi,bcm2712-firmware compatible
To: Gregor Herburger <gregor.herburger@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-4-cf8d725d8821@linutronix.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260508-rpi-otp-driver-v4-4-cf8d725d8821@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VXwmDxXv1IMyXZuF8tcpoT9e/fgk1b4+y/cmN3JMXJFfOTaHWc1
 o5VFjtIHHs4mdp1s/KUHnOm9vQhzvBxKzUHgZZ6b56KTPxW70O9RXI6tD/l1hKR7yqXiX2k
 WcIz+kl5KlG+lOcCSFrvVxsqhdn1OGgwR09RHQciOoBFafrdAAGJOvGJuzr9a2APqa84EGC
 xjgNSM0HmqwMmzFlrYsbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JxVKJv7Doq8=;B90uW/qHBUT387swqFgXwzuQ4q0
 XU5fRG2EKsybKFz6CLZuG4VbnD9RqqTKGJKsYKemLlE+9rrKIzJcLBzBM8rZTa6UabKWd0UhC
 mSBubZuGJa20e8ybw9sDPYXPsCodyeE0lYvlrfT+Va28MBTw3T6BybfXAToYRliFzPFAtvM3O
 zQaYfHBnG+IwO59BcxX7xajlZIe9mJ5kr3Tpd8quErlkGG566z9lwZCLzaEslBLSkBeTjCsOV
 IW5LwUNvcddG1K/Gm5qm8gpgY59UfrQiphzZULgV31OzYloe06A9KIHwv5RdqjeVtOEvuwuGy
 GH/drWdDRPjOYR8nSPRbpQl1UfMNfUMLNbsjaXMq462yKPSZLJucEZ5OWMPY3LAoMp9snTrOu
 Vmer265H1fEGO7fNHmxghjIZ/IAd1azQ70D6j7RbmZlWcQZq5FfoHBe6ZaVcdR8ZVtPzSNMQj
 gS92LhBbJ61kWdjEHyEBPXMB2vAhcn5kRZWhYOPE2hsaSqS9MVUguLFOwRBkekWerv/OwgLe7
 mJVrUy+/V3/Q/9P4LPdvA5Tt6itqKW4TnspK/r8TIUreiCxU99pkX84F+w1C8QXF90KGM91We
 dXWvyNwm5xW5wMO/C/Naj7KIdeXg90soHq0lU+hcP6lT14Yb1467N51JDBwKOSmUCfwQoAL8I
 I5xrEEh9TRu3E/A+F8Be4/mH4aGsi3YVNwcKo5HogC0xnW/s7uQ+tQzT0fpATXdslfZ+QMF0y
 fzKJq0momy1GbiH0j1QbLT7/tdgL+6B5IcNnM6GDrfQcRWhpNi5aif5nnAq90y4h5CgcCNnT8
 XN6ehFEnzzvUKJopg2DJlCADO89ZobUICQjuB9ocFM4L4nG7ugkG/OEtti/FZeH/w3vzde/m9
 /0G13Vjq1NY2kK/2GQ2wD2uh8m2FSbTdVIqi5GnAFyzVWDZPXhzgJQgTsWy0rb0RN7q1oOZrv
 EXePje2IW4KqT7V2r200Mhk1+O4wbXUKM/Q1BGCMrvH+KLEIsebMli3HGpORWJy3B1vLxIVBr
 S9tndq//zwuZFEbhj2+6iJoOx8ftF8sJDGYLRPpgMCKhvrPQgUPL4NLVS/bmP4RzXEufiHxyf
 iY7OMercVIKUv8c6VRoxggrnSo6uqnoA/VS7aFtgc8ikxx41zNqjAVC5qn/ZL4XIFOgpG2/W/
 LpiBnNX1LmO++IOuqjKX3WSN43EO0onx/HnohpbIUfIIuJb6iqEqMZdJO6eTxqQoBqOYTp+GD
 7MFpbvn389xcgM+QuJVziFLOMhJRG/fPiunHadrB3HuU6ljdrZC20BSGlXILtnB8uzfkIPma1
 /H0eBPJ5l4/QejRGr0QMEXkqMkTKixOGlyFhSqj0xIFk9l2jZl0fnNrvYa5nbTrxnf+1+k503
 DFJ2AXLz26xW5KzhH5439qkN5P8O/XR4f8jDsTlN/QwQiId2c4uyeozEYdw3L7xqb7u+mRoD/
 ddGA91fDt1VxhO3+6QMti7BHFpftQRVb/ZW4fcdB2s6JCbtIDPlqedupEEp1YrWNPlmI/WDzz
 Q8+Qb7XeA3VzrU3EHRkGZYKvhwCejkdPf4oPMQoJbitPZ2FxYUNS7LVOlok8kL32uzpytZm8Q
 Y5nBf5LuGgtKmaCbizakj478X8RqXaAPUxEQ8Y4lbjmFet9QDqsGjeHiRk7/AHppjWA0I28/F
 YPu60+hPGyNBnChTbYKh2QOQ5862DVtuOqATnnU7Rt8xuQkL0fxSlvm3Lv1QbT0BUGVxZhPb8
 IHO+BN76zz8O3yD+a1VjjfPAn1xhHQeq7DbLhL2BSr4qusbBvBJCDuBygfZxpcte5lP9I+zPj
 Atoa7amikPwUICm6QPbzBljczPIcHY9vaxgFAaF8p74Hi2qGy5hdlh/n5PVDzGdF8rnsUENje
 +fb9OBkW9QtP5XH2AWX6kNhTzbdChJRQk8j37RqHwnMpmkzv/1+WGprmUgXyz+csW0cH1TlLl
 BCzvj99GNGJ3RzBL/0ApFiZTEpWEGtFxeZ2l5pgLpZtHhGMWjlcg0I+wJ3YRqNRET+JBEQvXr
 Cy5qCT58se6wMRdr467ZwOfFNkrfHfekjHbfP7b3q4RHLrvW8ZISIFU0bRD+WQpHO4xsLoaY5
 ElNBwE8Vqd8LAzsi3WjNsIkcmKGKZPEdX39TStgxUYgupWOHzlyOfbykkhcqAab+dTdKsLj1+
 W/gUYCVdMfkzHv6201Co7heMoxI5ZKk4Znkzw42YCn134pKVB0fx8UW5RhU058RlemH9MAMhe
 ZeY064UT1RlTBPLMgeuBThh7Oei0vKYKnjIo21DvXn5pIxRsl7AXBMTUdxADNMyhB2OdkKy+7
 eBODfsTJmagorast+RduZGiYU/V2O+nshabQxfIN5FVE+mJ6Q90T6Snx1kkZBSmwS0w3pD9/2
 +FdJpyhK6k5ItVbB7M4YDfWWOkuWc9lfUPOVcQH25EsU8jtnlRVsjw9boQMk63zREcsoHhOoe
 xMIbpXSSmby8mWy4uyrocguKJKbR6TKeUHk49Sp102MGipqPlaSjem/G36QZ+wh633WB6Qwoj
 Em3oxHAAya/7ZwJok29SwE6aYjA/2IdxvShXKOjR0YX4JV/BFkYNYndAdf24j33iVpcRtZElB
 U3M3hyKBqk1pmtZFkhDY27uU2IRxgiyQt2TnQKkv4IJgfcV+xH1JmS5Qq+KfjzwspmxY2JSKQ
 EzYXBENlBF0RFQJKYMMC+OcZsdVIBDKXWSHEIk7w+jdLhvjI+AA5qndnnOCMef7owWLM6qL8L
 EVH1M43TVZ0kF55TQR9uodF/boCF8pd6qiECiyXi7GKFwUMv3ba95augUYJfLAW1VdKpWUOPS
 ZsbkaPzT/2bg7xgfVwrCM7TbRPL3LmZjpxXfCsaI7v3w24Pps6xb7qQHt9mSFGI6aiD4L7B0W
 eJxAM2s9xqr3cOcagffTxXbkxKT4VsdXeRYjQrcU+p4lZ7PScbXdEs/AXQJGF7dzdDrit6I1T
 LQkCjBvbT3i69tLdTj3qtzgg1zLwsx+dB1POxboqGgHjRU5vOK3No9vKsEP+pFOV6iRhB1LRS
 IbM5isxDO4SuRPyYV/bYrf1vrPaQ1fzi5bhBeC7fjkSmyGzcPHm8syuPtheNqcDEJmZ75F1w+
 KiGx9Eij9w6GYzugRKlamhCNedZ+7i3DSkWenHYWIwmjELzlzJu9I7o9GC4a5EQMnJ/fve21m
 tLCBM4AT/JYZeAZRmsTWhhssphWOiTnfEB+pfjrS2JUIDe4DNBhrpGLRtOpszek7X9YkEAfLD
 wizDnhrt5zBQUbFVSOhS1t4z/t6j2iJjwrVCyTF04AUyI21lfUprmrRlLoMUWpYb7sE1mymjr
 xsiLChJb+qjVpOLKlZBgVYR1FjN070EFy6qp7taRkpfkqnrum+EMzHhbEn317vD4/bLdCWhFC
 G3oYv3vNRy3AT5/Su5lgFNUFU5PWwXBalDGnqjOHhylUzNepnz4RKp48OAkXN71aSD8g45uJU
 jvo5pjUKh++ZRB0oPwscaxwfmpSfdB9WV6/tNmiabL6bSmgLRIWNGazhmC2aJuYQWD0Jx3G+o
 afAdNz5blFFU1IGL8raMoBpxjTC7NNL1xpUgQkqYQ+U/gWbgQibRZTF+mTEyy/DJ3FpjoPqUQ
 HMqVtEwvC8D36tAzOMB/W5XpNUXQrMbj6b0zwKfzrTvR7kRGehBXcWdNuUUQrFkbRt0NWBkTa
 9pvo+Px8k3WWOL1Hg/Fz7xzgCydJ2DwNXboBKXGwT64odbWwK3CMgziJiCxuKbLYsXsZUBTSQ
 VE/JAxuOZXy8mEBkq/HgtRKQ7PU9moUw3GJOC0o0bzXGCGB3pjzoIBBM+qW5njrtTr5NJhkQ1
 UiWZML6tQtoT/Sw93elRBsV+sxA/17pvicPQ6YezfChd4lmQaShk202YqZPxG5Rd6LsLEBLJ7
 IoW5w92Rz9kbOEdjesQJEVNIMRoEA1Ni0NodIOLtfs/d2M8UrGioKXhZVazEljQoahYwlwz8G
 vMXKhSxO0NOqbXXrJzCLX3hrta7Mlng6FQGQLoYQOb3sRseOkr+t9e166uHN/ToPy6rs3DtLP
 o0IxxbBgCAZV5aDizEnr2ll+gsgGjN1/eb0xgerQhAfM0tR20DjLTh+POkxxy27mv9huhUjgy
 x+YZOLklG3K8PHUXac/WcckPoF2HQ7qboH/vPZ7apuAtMvm7uaH+F8ds9poKQXxi0cuAXtB45
 Q+W8VFWXjBkXAGELfGMTLhyg3uVGUSIu4XubqIWOv2W2vazAfni7RuYYsSK85L6+lSi39hyEK
 R200pP91lTvaV1g1FEO7QVDXS1qA4xp7XEupABiVGfeJDJReZHa9edkpi1RiBR0Yx2+iaZIOE
 Fx9ix4TBJ5qb+/qF4zPTK5m6I/uhWPHwPoC2Rcmnm8v6fkPy5RNCznmvW+XG42ze/6jRtg8Hr
 lcDuMhj5X1QCPhYuHQhE/9a1YiqMPhhPMyT372tAitlRIZNzkOgcY6/nIv9ZO/eDJRhBQb4d1
 Bzflt3mG56/NzJiFpcXAEB+RR1ZxSSeqjvny3dmk9CI2SVP8teGMmQLsNodkRJcIY1dZ4DqEI
 CpA5zL15MSSk4XpniwyRe94n807q3TUst0riyqXKJSrFgmvPMhDwf03PWvfvjN+l5/FwZUM3U
 q/tOyOFXIAdvX5V/zDRDbT71w3g0PNsrqpwUtGwIkWc/g7IsyNJAnH5jkqfaOJdmSIT5qMO4S
 hz0pNQFynbjFNu8B6AEO0PpGrQ9HYdqFWaCo51/Gwi/Q8Yq4cgOnpI9SI3pPIU9bMQN/xNGbU
 MGSOBviISjC2nTcS700KLDXesiHR68CZt/SlLDGaMTfVDZQwX3jv/QzvajJQn/Xbql/YpbUPE
 FVxEc4lzVImXdyajJEdu13P/Va1qWOE6wp88CkIfPULgg+K3R4bf5qPcOcer6kpv++r2hK/oi
 FR0JUXDMGuCD9EQPyzfu4Mx7MofhXTwHGwoPJgoTf+TTMr0Vjr2fOGwbPveIqJIsTFmTdUAXP
 dl9B0jkgxfqit3hrWHYRpIXl6TW13CjHno2kVCwaWYwgD04byPhhM4tDtmoIYVeYuoNeQ19yK
 p5XM7f6pZ4Tzhd5r90ebKcYqZ8w2h6rttRQPEXLDdutHGYAauTW07MDCTpXqXKe0ipnZ0OMRP
 6mJ8uLpOEW2JjwuiI8l7A2BjOtuVs7ExTR6zWJhCAFXLBA7vJfe5bearEmt928CIp6XCgjdyy
 KiElOXNvUeZuiYDjbzUiXMAYOeanFBtjPLAbcFiVZ8rw49ojQk7ygBZarg2WHdG6BAwrhEAqz
 3ZrMDIvf8Z8NfmCSjqMGPDitjaAonSBHqoVkxQCGCys25E4Dgguyk4Pdoe9o62YIn6hcw7JZJ
 9Bi/7qAoXJ1zs2N4SV0HV/Y8aj3+w/a523rYlajNXgQf4BWqFVtvx5I41iR0bDwtXIoDpubB2
 xqNtP9G4WOG6B7zYmZy5NvuSjI2CoKEO1dzgmL9SB5QZa2nLTiasuHLUFx3UYDZ00OdpTapRL
 m1c1JVmWtx8IT1Q==

Am 08.05.26 um 16:42 schrieb Gregor Herburger:
> The Raspberry Pi 5 (BCM2712) firmware exposes additional features such
> as the additional OTP register region called 'private OTP'.
>
> Add the raspberrypi,bcm2712-firmware compatible to allow drivers to
> distinguish this hardware variant while keeping
> raspberrypi,bcm2835-firmware as a fallback for backward compatibility
> with existing drivers.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/ar=
ch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> index b7a6bc34ae1a..4aa8ec7601b8 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> @@ -46,7 +46,9 @@ power_button: power-button {
>  =20
>   	firmware {
>   		firmware: rpi-firmware {
> -			compatible =3D "raspberrypi,bcm2835-firmware", "simple-mfd";
> +			compatible =3D "raspberrypi,bcm2712-firmware",
> +				     "raspberrypi,bcm2835-firmware",
> +				     "simple-mfd";
>  =20
>   			mboxes =3D <&mailbox>;
>  =20
>


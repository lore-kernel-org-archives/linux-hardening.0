Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC12417D1;
	Thu,  3 Sep 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471967; cv=none; b=Bd9YxAZDrAZWbbbqAuR3cZmZgNcsYEQ37tJy0Ffn8xVoRlMe3eIsWJzTYMnhNMMkJxLjy7nN4E3/6cW7eLH/uAB0H3Ap9iKPM+ZOhW1Ik1YzWgmemXdQxXyriHT0YRqcF7nNgmyX3ieV4OjVtMV2GxkMqVfMmGA4o5MXG+I+ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471967; c=relaxed/simple;
	bh=OSZkD8409RE3z7t3qI++xt0tqEDQcGTo2G0z/Ygg8G0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcBy2nLPBG1O2lsqGdifaJre/9+XAiqAhEHoxNf+O0TIP5iPJ9+RKUDE/s6HEyyhyOjp365qNM+Qjfx2KuUvAN50f4rHfVi8KhWZb+iBjAi7I33Y/W2x5PRTU056kqY14EIoBjJCVI2kiJAPMEwWFPqNoCk95AsRSVe7IsvSQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6Gb1lB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6Gb1lB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F01F00A3D;
	Thu,  3 Sep 2026 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471966;
	bh=KgXEKz1APqLPG4nyWY2AN2NntonWjikKHDW+8kArWTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f6Gb1lB2ycQCnWVKtd8TAkb6Vh29B+JxhJWb3Uotmn1xL67ilA130es81D2+W2ZlQ
	 9mNyUz9H75UTOm07kFq8FZqIIIddohYUPezblkOBsQBzuyh26A5QXkYC1jAHsyhT9S
	 iYf1Kru+UmeKaKZT7zMRmU994Pc/MZXVy0USd9bODFyWuYYmQZ0jkyjaZlFPpgETrW
	 LsEovyO5tF+4BVBVSkEeqReyYKaHQZULWFUZF740uCmDNT63UK132BKtYCHbvyJ0+N
	 89ugxpfd7Xhp09TXoajmMmvgHNCC1T+CXsXdr7pIC7DPkZdDHdzF6/86wZ269knaIo
	 eQWMT2flzWWCg==
Subject: Re: [3/7] net: mctp: usblib: Add tests of invalid headers
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 03 Sep 2026 21:46:04 +0000
Message-ID: <178847196492.3394541.5164042394634621124@kernel.org>
In-Reply-To:
 <20260831-dev-mctp-usb-lib-test-v1-3-79699bf67a18@codeconstruct.com.au>
References:
 <20260831-dev-mctp-usb-lib-test-v1-3-79699bf67a18@codeconstruct.com.au>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Undisclosed fixup hunk: besides adding the two new test cases
  described in the changelog, this patch silently deletes the unused…
- [Low] The new negative test `mctp_usblib_test_rx_short_packet()`
  documents and exercises the wrong minimum-length boundary.

--

net: mctp: usblib: Add tests of invalid headers

Adds two kunit cases to the mctp-usblib tests: one submitting a packet
whose USB transport header length field is below the minimum, and one
submitting a packet with a corrupted DMTF ID. Both expect -EPROTO from
mctp_usblib_rx_complete(), a NULL rx->skb, and an empty rx queue.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 1a6dd6d10daa..4f499de9a6ce 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c
> @@ -440,7 +440,6 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
>  	struct mctp_usblib_test_dev *dev;
>  	struct mctp_usblib_test_ctx *ctx;
>  	struct mctp_usblib_rx *rx;
> -	size_t i;
>  
>  	ctx = mctp_usblib_test_init(test);
>  	rx = mctp_usblib_test_rx_init(test, true);

[Severity: Low]
Should this hunk be squashed into the previous patch instead?  The commit
message only mentions adding invalid-header tests, but this removes an
unused declaration from mctp_usblib_test_rx_header_splits(), which is a
different function and unrelated to the new cases.

That declaration arrives with the preceding patch "net: mctp: usblib: Add
test for splits inside headers", where the body only contains the unrolled
calls and never uses i:

	struct mctp_usblib_rx *rx;
	size_t i;

	ctx = mctp_usblib_test_init(test);
	rx = mctp_usblib_test_rx_init(test, true);
	dev = ctx->dev;

	mctp_usblib_test_rx_split_header(test, 1, dev, rx);
	...
	mctp_usblib_test_rx_split_header(test, 8, dev, rx);

So the intermediate commit builds with a -Wunused-variable warning, which
shows up during a bisect.  Would folding the removal into that patch (or at
least mentioning it in this changelog) be preferable?

> @@ -459,11 +458,79 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
>  	mctp_usblib_test_rx_split_header(test, 8, dev, rx);
>  }
>  
> +/* Test the submission of a packet with an impossibly small value in the
> + * header's length field. Values less than HDR_LEN are invalid.
> + */
> +static void mctp_usblib_test_rx_short_packet(struct kunit *test)
> +{

[Severity: Low]
Is "Values less than HDR_LEN are invalid" the right threshold here?
HDR_LEN is sizeof(struct mctp_usb_hdr), i.e. 4, but the check in
mctp_usblib_rx_complete() rejects anything below the USB header plus the
MCTP header, i.e. 8:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_rx_complete() {
	...
	if (pkt_len < sizeof(*hdr) + sizeof(struct mctp_hdr)) {
		netdev_dbg(netdev, "rx: invalid len %d\n", pkt_len);
		rc = -EPROTO;
		goto err_reset;
	}
	...
}

> +	len = sizeof(pktbuf);
> +	mctp_usblib_test_init_pkt(pktbuf, len, HDR_LEN - 1);

Following on from the comment above, does this pin the boundary the test
name suggests?  With hdr.usb.len set to 3, the case still passes if the
driver check were weakened to pkt_len < sizeof(*hdr), so lengths of 4..7
stay uncovered.

Those are the values that would otherwise reach the pkt_len == skb->len /
skb_clone path and hand mctp_usblib_rx() an skb whose
skb_pull(skb, sizeof(struct mctp_usb_hdr)) leaves no struct mctp_hdr behind
the USB header.

Would HDR_LEN + sizeof(struct mctp_hdr) - 1, or a parameterised sweep over
0..7, be a closer match to the validation being tested?  The comment and
the value are unchanged through the end of the series (0782a305), so this
applies to the final state of the file too.

> +	buflen = 0;
> +	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +	KUNIT_ASSERT_GE(test, buflen, len);
> +
> +	memcpy(buf, pktbuf, len);
> +
> +	rc = mctp_usblib_rx_complete(dev->ndev, rx, len);
> +	KUNIT_EXPECT_EQ(test, rc, -EPROTO);
> +	KUNIT_EXPECT_NULL(test, rx->skb);
> +	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18%40codeconstruct.com.au

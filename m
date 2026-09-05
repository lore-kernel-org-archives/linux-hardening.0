Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A602C11E7;
	Sat,  5 Sep 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623895; cv=none; b=f3ydky0ttQGNBR1Gc0yS9o4mIOY6jPZM9wP2H3Ludt4OTQTFD+qGMr6CUX8SaqZmo+hsgM/UixA+nsngKv1A0gRnj0STqZ2ehBGBfxSsDrzcYeoQQwQF0w21iqj8gtOy/AhsQjit7+mi59MG+BTOR7xZJistlVGpogRtBjnyqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623895; c=relaxed/simple;
	bh=jIPHGoVNyX3n3d2jhccjAWHbYxOoapEK63HKPaua1pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJp43jqTeXiOnCZi1yHcav1n2AQeZfCDkpabY+v3FRdzjRgEkV0HyDtruLL3L8dF0ofw/7WFzfPxPI9NMYHd70FkdnCbubSdjW7sX3wxC56NDMLOUnIeHFch9BG9vj2TvA0JXvBoJzMklYYUq36wBxAc75doEfJXWyd2CA7VW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6p8GrhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6p8GrhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3B81F00A3A;
	Sat,  5 Sep 2026 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788623893;
	bh=lvtAkeiZFMtKq1uyTJphO+QXdbVjS2bljjLXW7tgkNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6p8GrhApyYSZS39h3kEi3oEIeNWOsd9a/dPrIssAcwEhaBFqepLC62vwrD/fq8qa
	 lyb8xvy+CUd8dgpA14du0fWdQPj2FYEeRA8dMo7pqlWDX6VxAriALyBnm9XD9SjppF
	 +F6Gl+bMmgjwFuBD7tDjLgVtARPkSmi/tCU/MeKB8+IPs77JexXDdBFTn6yAj97BkL
	 Tj63duATL2Td121v34DdVP/raqYV6wtgI+f/4QYAmSBxoQlhzBDsTRIuSHPBpIvyD1
	 zNMOuulI2A8j/kZHy5J+zc1+Aw97ZqiNONlBArTmQ3zYp5SgJHud9L6uTS/Sz4odz0
	 kfIS6/Ud1UH5w==
From: Simon Horman <horms@kernel.org>
To: kees@kernel.org
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	luoxuanqiang@kylinos.cn,
	tim.bird@sony.com,
	zihanx@nebusec.ai,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] llc: add KUnit tests for the connection state machine bounds
Date: Sat,  5 Sep 2026 16:58:01 +0100
Message-ID: <20260905155801.110741-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901210308.1173180-3-kees@kernel.org>
References: <20260901210308.1173180-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260901210308.1173180-3-kees@kernel.org?part=3
---
llc: add KUnit tests for the connection state machine bounds

This commit adds a KUnit test suite for the LLC type 2 connection state
machine. It introduces regression tests for state transitions and array
indexing invariants.

> diff --git a/net/llc/tests/conn_kunit.c b/net/llc/tests/conn_kunit.c
> new file mode 100644
> index 0000000000000..86d3f122df0a6
> --- /dev/null
> +++ b/net/llc/tests/conn_kunit.c
> @@ -0,0 +1,146 @@

[ ... ]

> +static struct sk_buff *llc_conn_test_rx_pdu(struct kunit *test, struct sock *sk)
> +{
> +	struct llc_conn_state_ev *ev;
> +	struct llc_pdu_sn *pdu;
> +	struct sk_buff *skb;
> +
> +	skb = alloc_skb(sizeof(*pdu), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, skb);

[Severity: Medium]
Will this leak unmanaged resources if the assertion fails?

If alloc_skb() fails, KUNIT_ASSERT_NOT_NULL() terminates the test case
abruptly. Any previously allocated resources that are not registered with
KUnit's cleanup mechanism (like kunit_add_action()) will bypass their
manual cleanup routines.

[ ... ]

> +static void llc_conn_state_process_out_of_svc(struct kunit *test)
> +{
> +	struct sk_buff *first, *second;
> +	struct socket *sock;
> +	struct sock *sk;
> +
> +	sock = llc_conn_test_socket(test);
> +	sk = sock->sk;
> +
> +	first = llc_conn_test_rx_pdu(test, sk);
> +	second = llc_conn_test_rx_pdu(test, sk);

[Severity: Medium]
For instance, if the second call to llc_conn_test_rx_pdu() triggers an
assertion failure, does this code leak the socket and the first sk_buff?

The sock is allocated in llc_conn_test_socket(), and the first sk_buff is
allocated just above. Because KUNIT_ASSERT_NOT_NULL() causes an immediate
abort on failure, the execution would skip the sock_release(sock) call at the
end of this function, permanently leaking both the socket and the sk_buff.

> +
> +	lock_sock(sk);
> +	KUNIT_EXPECT_EQ(test, llc_sk(sk)->state, LLC_CONN_STATE_ADM);

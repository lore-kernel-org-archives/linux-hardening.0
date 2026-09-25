Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915B4E431F;
	Fri, 25 Sep 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354648; cv=none; b=OS/6+jo/NZq9qKTNu6U/3NrrxysV034kiaSEmJdVtko1+KG/AK96uOw/92yP3RTGvj1AvDDYBZp0xRQMr8O7puS0qLqclfdYrojT29hZBueR0N49l0IEwsygvRnIFhdZHIvESypG49aEeHfueFqOjiayXyYvZsijNoBgKpn/IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354648; c=relaxed/simple;
	bh=U9htE2TEygn2cXCFGk2WH7O59NTVLt7jNsV+zjtjfXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEDk6RUMF3v3n/APy0fagp+E1Gv721O1bwGriwboz+pXbqmF/dGbHqBEvTB62O3RfF4NyePyQu7iJ4+NQF+Ev2fM8+lQPg+55m9gdtdCbpE6WZ9C22kzYG2q3N4rbb3XfsdEq12aG1Je0HpV+s3GN3nq/nq3HyljnP6e2UEjMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoeBYbms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoeBYbms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EAC1F000FF;
	Fri, 25 Sep 2026 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354631;
	bh=6wt+sGxsGvNuEx7Eu5O6b/MopcidBDXDseFUxK55EkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DoeBYbmstEnAYdDB6nx/JdHGwpSMjCsqE7nvbatO8ZfRIutkuF/Yxb/5aul1r0ln5
	 vyUf6909mPR/kPC73s4Vg7wXikwBmR8Nq1bXA+JJrZEQglgoQNmw7cjukSH/DllJDO
	 iOO98jKSsXNWrlY4uzbgZbsRXO5gJv8EoiGmUHbAg4ooIxPvPGTmaEFjPtlgR7r9dg
	 vr9fdH+SiH/gJBqM9nQRdF0W/PiB2vIO0kU5RAj51pKlxKTnRlc9Y3Bnjy45oN5Ff1
	 St4IpjNhbXuZFTRP+rbpQyTcnQj/0ZEqXzVmnyvyfVzKgqV7SVS+uWOnycjKON65Wk
	 DLLZCXYVbDmWQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Luo Jie <jie.luo@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	gustavoars@kernel.org,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
Date: Fri, 25 Sep 2026 11:43:25 -0500
Message-ID: <179035461233.1296652.12548015933969363392.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <AS8P251MB000187BDFAD98A21F4C356E9C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB000187BDFAD98A21F4C356E9C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 12 Sep 2026 14:09:06 +0100, Aamir Ahmed wrote:
> hw_data->hws[] is annotated with __counted_by(num), so hw_data->num
> must hold the element count before the array is accessed.
> ipq_cmn_pll_register_clks() assigns it only after storing the fixed
> rate output clocks and the CMN PLL, and the unwind loop under
> unregister_fixed_clk reads .hws[] with .num still zero. Both are
> out-of-bounds accesses under CONFIG_UBSAN_BOUNDS.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
      commit: 9ea48293af5be389f6c6ca9c9654a0ad52a42f54

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

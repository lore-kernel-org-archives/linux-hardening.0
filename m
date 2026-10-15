Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7924E36D6
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054700; cv=none; b=q3PY3pkQVmwS0rnHQXe8rV4Zv9IEW6KMOqF8a0lOrrdHJ48jNqK2ACZZqE+43dSWh6Ub6A3tV/u4QiAd7KItKBp5sJWt43PJB8qk5ueeDMbBwa4sQFazjWMGmxbl6+JxL9n7FtmsO7xrb2+VibkP+bnW25dfoJtteVWbwgVT7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054700; c=relaxed/simple;
	bh=wzDpvDBL5Yx7n/5s8VwPlzFDqaUnwQNIk6WZUwL5PYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rwq1kaEhDR8DuN7PlLTEMNuKc/6XduLdKPaHV0gFjZJLNWG6YtFSHrbXF6ryv+ZISkzK+meXx37eBdsRLtVCFIE7yLf94n3sSDP/x7c6uyIpHGy+fCtXQsHkbNnXqx2C/ksAT8+4QmUh02mYnUfp5+kGsw3Jt9xa4vmZQhYqQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K9sfwMTv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WfcUsl4/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K9sfwMTv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WfcUsl4/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K9sfwMTv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WfcUsl4/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K9sfwMTv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WfcUsl4/"
Received: from murzim.nue2.suse.org (unknown [10.168.4.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9327422312;
	Thu, 15 Oct 2026 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792054693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBtEnUpDxb3vSID8mI4QZtKMW50lKrUhn3FqsL+0FVA=;
	b=K9sfwMTvyyC1/DFvOsAR3NJFzF69MhCydAy+wXUX9qoVm/AeINW240uq6chlXAWS8k8qiz
	fHRUiUYVbzfAIj/szyUDcRSGZE/oQiirxlQoB320S7USyKX2beeDQ9PnkRcFGHBcxsJeCg
	owNVk8ts63mSQ2hlFufAv7jAYMKYDS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792054693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBtEnUpDxb3vSID8mI4QZtKMW50lKrUhn3FqsL+0FVA=;
	b=WfcUsl4/SeJ2bsW84SEBEZMUvOkInCEdkqcK5zkxR85bBPUqDUwBH28CScofQcQ2hcQaiu
	m1FWT+rRmFMo8fDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792054693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBtEnUpDxb3vSID8mI4QZtKMW50lKrUhn3FqsL+0FVA=;
	b=K9sfwMTvyyC1/DFvOsAR3NJFzF69MhCydAy+wXUX9qoVm/AeINW240uq6chlXAWS8k8qiz
	fHRUiUYVbzfAIj/szyUDcRSGZE/oQiirxlQoB320S7USyKX2beeDQ9PnkRcFGHBcxsJeCg
	owNVk8ts63mSQ2hlFufAv7jAYMKYDS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792054693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBtEnUpDxb3vSID8mI4QZtKMW50lKrUhn3FqsL+0FVA=;
	b=WfcUsl4/SeJ2bsW84SEBEZMUvOkInCEdkqcK5zkxR85bBPUqDUwBH28CScofQcQ2hcQaiu
	m1FWT+rRmFMo8fDQ==
Date: Thu, 15 Oct 2026 10:58:13 +0200 (CEST)
From: Richard Biener <rguenther@suse.de>
To: Kees Cook <kees@kernel.org>
cc: Richard Biener <richard.guenther@gmail.com>, Jan Hubicka <hubicka@ucw.cz>, 
    Martin Jambor <mjambor@suse.cz>, gcc-patches@gcc.gnu.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA
 [PR105438]
In-Reply-To: <39r25275-0488-rq01-55nq-28rs192rp368@fhfr.qr>
Message-ID: <76op6r8p-n2p7-r6p8-s541-rs310035q364@fhfr.qr>
References: <20261010050537.i.784-kees@kernel.org> <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com> <20261015052441.7d2b3c-kees@kernel.org> <39r25275-0488-rq01-55nq-28rs192rp368@fhfr.qr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1475677436-904524837-1792054693=:5350"
X-Spamd-Result: default: False [-1.57 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-0.98)[-0.982];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.09)[-0.429];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ucw.cz,suse.cz,gcc.gnu.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[murzim.nue2.suse.org:helo];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -1.57
X-Spam-Level: 
X-Spam-Flag: NO

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1475677436-904524837-1792054693=:5350
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Oct 2026, Richard Biener wrote:

> On Wed, 14 Oct 2026, Kees Cook wrote:
> 
> > On Sun, Oct 11, 2026 at 04:50:41PM +0200, Richard Biener wrote:
> > > >     In function 'small_to_big', inlined from 'f' at t.c:22:3:
> > > >     warning: array subscript 'struct big[0]' is partly outside array bounds of 'struct small[1]' [-Warray-bounds=]
> > >
> > > I think these diagnostics are dubious with -fno-strict-aliasing which
> > > essentially says you can access every object via any other objects type.
> > 
> > The source has no such access, though: each function reads and writes
> > members through its own types, and every byte touched is inside the
> > object. The "struct big" access to a "struct small" exists only in the
> > body ICF picked, so the warning is about code GCC wrote rather than
> > code the programmer wrote.
> > 
> > > So instead of this I'd rather work towards inlining the original
> > > body rather than the ICF prevailing one.
> > 
> > That does seem like it could be better, but it's not clear to me how
> > large a project that would be to accomplish.
> 
> I think for the case of ICF and non-LTO it should be possible to
> "hack" this in;  it should be just to make sure the inline edges
> point to the original body and hopefully the ICF "merge" is somehow
> encoded clearly.  When the inline edge is set up correctly it should
> possibly even work with LTO.

I one-shotted the attached.  It definitely fails to do this in a
proper IPA way - it should have used IPA function/variable transform
stages and stream out the "defered aliases" in 
write/read_optimization_summary.

I'm sure this can be completed with some interaction, but our AI
policy makes this questionable.

Richard.

> > This patch seems to DTRT, though. It doesn't appear to regress merging
> > in a meaningful way for the Linux at least.
> 
> I don't dispute this, but it feels like a hack.  Either ICF should
> work as if -fstrict-aliasing were given, but consistently so, and
> for a good reason, or you could as well do -fno-ipa-icf when
> building the kernel as you are doing so many we-don't-quite-want-C
> things already.
> 
> > > And force-disable these kind of diagnostics with -fno-strict-aliasing?
> > 
> > I'd really rather not. Linux builds everything with -fno-strict-aliasing,
> > so that would remove these checks from the kernel entirely. GCC's
> > -Warray-bounds is still off by default for the kernel because of false
> > positives like this one (which is why I'm trying to solve it), and I've
> > been working toward enabling it, since it finds real bugs. (I have a
> > stack of a dozen real issues that this found while doing a recent pass.)
> > 
> > For example (since I don't yet have links to the above stack), here
> > are some random examples from a few years ago: a response struct passed
> > where a bigger error struct was expected, whose "error" field was past
> > the end of the object[1]:
> > 
> >   drivers/thunderbolt/xdomain.c:226:22: error: array subscript 'const struct tb_xdp_error_response[0]' is partly outside array bounds of 'struct tb_xdp_properties_changed_response[1]'
> > 
> > and a u64 remainder stored into an int on the stack[2]:
> > 
> >   include/linux/math64.h:56:20: error: array subscript 'u64 {aka long long unsigned int}[0]' is partly outside array bounds of 'int[1]'
> > 
> > But if you did disable diagnostics, which did you have in mind? If it's
> > only warnings about an access whose type is bigger than the object while
> > the bytes it touches are in bounds, that's narrower, but the first
> > example above would still need to be caught, so I'd much rather just
> > get ICF behaving nicely. :)
> > 
> > -Kees
> > 
> > [1] https://git.kernel.org/linus/19813551701d0
> > [2] https://git.kernel.org/linus/9f3d543a9f737
> > 
> > 
> 
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE Software Solutions Germany GmbH,
Frankenstrasse 146, 90461 Nuernberg, Germany;
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri; (HRB 36809, AG Nuernberg)
---1475677436-904524837-1792054693=:5350
Content-Type: text/plain; charset=US-ASCII; name=pp
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=pp

RnJvbSA2MDQxOGI3ZGEzYTRiODhhNDczMzY0ODhiMWQxYzI2NTY3ODZjNWM0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogUmljaGFyZCBCaWVu
ZXIgPHJndWVudGhlckBzdXNlLmRlPg0KRGF0ZTogVGh1LCAxNSBPY3QgMjAy
NiAxMDo0MjowOCArMDIwMA0KU3ViamVjdDogW1BBVENIXSBpcGEtaWNmOiBE
ZWZlciBjcmVhdGluZyBhbGlhc2VzIHVudGlsIGFmdGVyIGlubGluaW5nDQog
W1BSMTA1NDM4XQ0KDQpXaGVuIElQQS1JQ0YgbWVyZ2VzIHR3byBmdW5jdGlv
bnMgYnkgY3JlYXRpbmcgYW4gYWxpYXMgYW5kIHJlbGVhc2luZw0KdGhlIGFs
aWFzJ3MgYm9keSBiZWZvcmUgaW5saW5pbmcsIGlubGluaW5nIGNhbGxzIHRv
IHRoZSBhbGlhcyBpbmxpbmVzDQp0aGUgSUNGLWNob3NlbiBwcmV2YWlsaW5n
IGJvZHkgaW5zdGVhZCBvZiB0aGUgb3JpZ2luYWwgYm9keS4gIFdoZW4gdGhl
DQpmdW5jdGlvbnMgb3BlcmF0ZSBvbiBkaWZmZXJlbnQgdHlwZXMgKHN1Y2gg
YXMgZGlmZmVyZW50IGFycmF5IGJvdW5kcw0Kb3Igc3RydWN0dXJlIGxheW91
dHMpLCB0aGlzIG1peGVzIHVwIHR5cGVzIGFuZCBkZWNsYXJhdGlvbnMgaW4g
dGhlDQppbmxpbmVkIGJvZHksIHRyaWdnZXJpbmcgYm9ndXMgZGlhZ25vc3Rp
Y3Mgc3VjaCBhcyAtV2FycmF5LWJvdW5kcy4NCg0KVGhpcyBwYXRjaCBkZWZl
cnMgdGhlIGNyZWF0aW9uIG9mIElDRiBzeW1ib2wgYWxpYXNlcyBhbmQgYm9k
eSByZW1vdmFsDQp1bnRpbCBhZnRlciBpbmxpbmluZy4gIElmIGFuIGFsaWFz
IGZ1bmN0aW9uIHdhcyBpbmxpbmVkIGludG8gYWxsIG9mIGl0cw0KY2FsbGVy
cywgaXRzIG9yaWdpbmFsIGJvZHkgd2FzIGlubGluZWQgd2l0aCBpdHMgb3Jp
Z2luYWwgdHlwZXMgYW5kIGRlY2xhcmF0aW9ucw0KYW5kIG5vIGFsaWFzIG5l
ZWRzIHRvIGJlIGNyZWF0ZWQuICBJZiBjYWxscyByZW1haW4gb3IgdGhlIGZ1
bmN0aW9uIGlzDQpuZWVkZWQgb2ZmbGluZSwgdGhlIGFsaWFzIHRvIHRoZSBw
cmV2YWlsaW5nIGZ1bmN0aW9uIGlzIGNyZWF0ZWQgYWZ0ZXIgaW5saW5pbmcu
DQoNCglQUiBpcGEvMTA1NDM4DQoNCmdjYy9DaGFuZ2VMb2c6DQoNCgkqIGlw
YS1pY2YuaCAoaXBhX2ljZl9jcmVhdGVfZGVmZXJyZWRfYWxpYXNlcyk6IERl
Y2xhcmUuDQoJKiB0cmVlLXBhc3MuaCAoaXBhX2ljZl9jcmVhdGVfZGVmZXJy
ZWRfYWxpYXNlcyk6IERlY2xhcmUuDQoJKiBpcGEtaWNmLmNjIChkZWZlcnJl
ZF9tZXJnZV9hbGlhc2VzKTogTmV3IHN0YXRpYyB2YXJpYWJsZS4NCgkoc2Vt
X2Z1bmN0aW9uOjptZXJnZSk6IERlZmVyIGFsaWFzIGNyZWF0aW9uIGJ5IHB1
c2hpbmcgdG8NCglkZWZlcnJlZF9tZXJnZV9hbGlhc2VzLg0KCShpcGFfaWNm
X2NyZWF0ZV9kZWZlcnJlZF9hbGlhc2VzKTogTmV3IGZ1bmN0aW9uLg0KCShp
cGFfaWNmX2NjX2ZpbmFsaXplKTogUmVsZWFzZSBkZWZlcnJlZF9tZXJnZV9h
bGlhc2VzLg0KCSogaXBhLWlubGluZS5jYyAoaXBhX2lubGluZSk6IENhbGwg
aXBhX2ljZl9jcmVhdGVfZGVmZXJyZWRfYWxpYXNlcy4NCg0KZ2NjL3Rlc3Rz
dWl0ZS9DaGFuZ2VMb2c6DQoNCgkqIGcrKy5kZy9pcGEvcHIxMDU0MzguQzog
TmV3IHRlc3QuDQoJKiBnKysuZGcvaXBhL3ByMTA1NDM4LTIuQzogTmV3IHRl
c3QuDQotLS0NCiBnY2MvaXBhLWljZi5jYyAgICAgICAgICAgICAgICAgICAg
ICAgIHwgNzQgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQogZ2NjL2lw
YS1pY2YuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsNCiBnY2Mv
aXBhLWlubGluZS5jYyAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysNCiBn
Y2MvdGVzdHN1aXRlL2crKy5kZy9pcGEvcHIxMDU0MzgtMi5DIHwgMjUgKysr
KysrKysrDQogZ2NjL3Rlc3RzdWl0ZS9nKysuZGcvaXBhL3ByMTA1NDM4LkMg
ICB8IDI1ICsrKysrKysrKw0KIGdjYy90cmVlLXBhc3MuaCAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMSArDQogNiBmaWxlcyBjaGFuZ2VkLCAxMTcgaW5z
ZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGdjYy90ZXN0c3VpdGUvZysrLmRnL2lwYS9wcjEwNTQzOC0yLkMNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZ2NjL3Rlc3RzdWl0ZS9nKysuZGcvaXBhL3By
MTA1NDM4LkMNCg0KZGlmZiAtLWdpdCBhL2djYy9pcGEtaWNmLmNjIGIvZ2Nj
L2lwYS1pY2YuY2MNCmluZGV4IDY0Y2M3MjJiZDdhLi41ZTEzYjI2N2I3ZSAx
MDA2NDQNCi0tLSBhL2djYy9pcGEtaWNmLmNjDQorKysgYi9nY2MvaXBhLWlj
Zi5jYw0KQEAgLTEwMCw2ICsxMDAsNyBAQCBuYW1lc3BhY2UgaXBhX2ljZiB7
DQogICAgYXJlIHByb3BhZ2F0ZWQgbGF0ZXIgb24uICAqLw0KIA0KIHN0YXRp
YyBzZW1faXRlbV9vcHRpbWl6ZXIgKm9wdGltaXplciA9IE5VTEw7DQorc3Rh
dGljIHZlYzxzdGQ6OnBhaXI8Y2dyYXBoX25vZGUgKiwgY2dyYXBoX25vZGUg
Kj4gPiBkZWZlcnJlZF9tZXJnZV9hbGlhc2VzOw0KIA0KIC8qIENvbnN0cnVj
dG9yLiAgKi8NCiANCkBAIC0xMjg1LDIyICsxMjg2LDkgQEAgc2VtX2Z1bmN0
aW9uOjptZXJnZSAoc2VtX2l0ZW0gKmFsaWFzX2l0ZW0pDQogICBlbHNlIGlm
IChjcmVhdGVfYWxpYXMpDQogICAgIHsNCiAgICAgICBhbGlhcy0+aWNmX21l
cmdlZCA9IHRydWU7DQorICAgICAgb3JpZ2luYWwtPmljZl9tZXJnZWQgPSB0
cnVlOw0KIA0KLSAgICAgIC8qIFJlbW92ZSB0aGUgZnVuY3Rpb24ncyBib2R5
LiAgKi8NCi0gICAgICBpcGFfbWVyZ2VfcHJvZmlsZXMgKG9yaWdpbmFsLCBh
bGlhcyk7DQotICAgICAgc3ltdGFiLT5jYWxsX2NncmFwaF9yZW1vdmFsX2hv
b2tzIChhbGlhcyk7DQotICAgICAgYWxpYXMtPnJlbGVhc2VfYm9keSAodHJ1
ZSk7DQotICAgICAgYWxpYXMtPnJlc2V0ICgpOw0KLSAgICAgIC8qIE5vdGlj
ZSBnbG9iYWwgc3ltYm9sIHBvc3NpYmx5IHByb2R1Y2VkIFJUTC4gICovDQot
ICAgICAgKChzeW10YWJfbm9kZSAqKWFsaWFzKS0+Y2FsbF9mb3Jfc3ltYm9s
X2FuZF9hbGlhc2VzIChjbGVhcl9kZWNsX3J0bCwNCi0JCQkJCQkJICAgTlVM
TCwgdHJ1ZSk7DQotDQotICAgICAgLyogQ3JlYXRlIHRoZSBhbGlhcy4gICov
DQotICAgICAgY2dyYXBoX25vZGU6OmNyZWF0ZV9hbGlhcyAoYWxpYXNfZnVu
Yy0+ZGVjbCwgZGVjbCk7DQotICAgICAgYWxpYXMtPnJlc29sdmVfYWxpYXMg
KG9yaWdpbmFsKTsNCi0NCi0gICAgICBvcmlnaW5hbC0+Y2FsbF9mb3Jfc3lt
Ym9sX3RodW5rc19hbmRfYWxpYXNlcw0KLQkgKHNldF9sb2NhbCwgKHZvaWQg
Kikoc2l6ZV90KSBvcmlnaW5hbC0+bG9jYWxfcCAoKSwgdHJ1ZSk7DQorICAg
ICAgZGVmZXJyZWRfbWVyZ2VfYWxpYXNlcy5zYWZlX3B1c2ggKHN0ZDo6bWFr
ZV9wYWlyIChvcmlnaW5hbCwgYWxpYXMpKTsNCiANCiAgICAgICBpZiAoZHVt
cF9lbmFibGVkX3AgKCkpDQogCWR1bXBfcHJpbnRmIChNU0dfT1BUSU1JWkVE
X0xPQ0FUSU9OUywNCkBAIC0zNzIyLDEyICszNzEwLDY3IEBAIHB1YmxpYzoN
CiANCiB9IC8vIGlwYV9pY2YgbmFtZXNwYWNlDQogDQordXNpbmcgbmFtZXNw
YWNlIGlwYV9pY2Y7DQorDQogaXBhX29wdF9wYXNzX2QgKg0KIG1ha2VfcGFz
c19pcGFfaWNmIChnY2M6OmNvbnRleHQgKmN0eHQpDQogew0KICAgcmV0dXJu
IG5ldyBpcGFfaWNmOjpwYXNzX2lwYV9pY2YgKGN0eHQpOw0KIH0NCiANCisv
KiBDcmVhdGUgZGVmZXJyZWQgSUNGIGFsaWFzZXMgYWZ0ZXIgaW5saW5pbmcu
ICAqLw0KKw0KK3ZvaWQNCitpcGFfaWNmX2NyZWF0ZV9kZWZlcnJlZF9hbGlh
c2VzICh2b2lkKQ0KK3sNCisgIGZvciAodW5zaWduZWQgaSA9IDA7IGkgPCBk
ZWZlcnJlZF9tZXJnZV9hbGlhc2VzLmxlbmd0aCAoKTsgaSsrKQ0KKyAgICB7
DQorICAgICAgY2dyYXBoX25vZGUgKm9yaWdpbmFsDQorCT0gZGVmZXJyZWRf
bWVyZ2VfYWxpYXNlc1tpXS5maXJzdC0+dWx0aW1hdGVfYWxpYXNfdGFyZ2V0
ICgpOw0KKyAgICAgIGNncmFwaF9ub2RlICphbGlhcyA9IGRlZmVycmVkX21l
cmdlX2FsaWFzZXNbaV0uc2Vjb25kOw0KKw0KKyAgICAgIGlmIChhbGlhcy0+
Ym9keV9yZW1vdmVkIHx8IGFsaWFzLT5pbmxpbmVkX3RvKQ0KKwljb250aW51
ZTsNCisNCisgICAgICAvKiBJZiB0aGUgYWxpYXMgZnVuY3Rpb24gd2FzIGlu
bGluZWQgaW50byBhbGwgY2FsbGVycyBhbmQgY2FuIGJlDQorCSByZW1vdmVk
LCBpdHMgb3JpZ2luYWwgYm9keSB3YXMgaW5saW5lZCBhbmQgbm8gb2ZmbGlu
ZSBjb3B5IGlzDQorCSBuZWVkZWQuICAqLw0KKyAgICAgIGlmICghYWxpYXMt
PmNhbGxlcnMgJiYgYWxpYXMtPmNhbl9yZW1vdmVfaWZfbm9fZGlyZWN0X2Nh
bGxzX3AgKCkpDQorCWNvbnRpbnVlOw0KKw0KKyAgICAgIGlmIChvcmlnaW5h
bC0+aW5saW5lZF90bykNCisJY29udGludWU7DQorDQorICAgICAgaWYgKGFs
aWFzLT5jbG9uZXMpDQorCXsNCisJICAvKiBJZiBhbGlhcyBoYXMgaW5saW5l
IGNsb25lcywgd2UgY2Fubm90IHJlbGVhc2UgaXRzIGJvZHkuDQorCSAgICAg
UmVkaXJlY3QgZGlyZWN0IGNhbGxlcnMgdG8gb3JpZ2luYWwgaW5zdGVhZC4g
ICovDQorCSAgcmVkaXJlY3RfYWxsX2NhbGxlcnMgKGFsaWFzLCBvcmlnaW5h
bCk7DQorCSAgY29udGludWU7DQorCX0NCisNCisgICAgICBjZ3JhcGhfZWRn
ZSAqZSwgKm5leHQ7DQorICAgICAgZm9yIChlID0gYWxpYXMtPmNhbGxlZXM7
IGU7IGUgPSBuZXh0KQ0KKwl7DQorCSAgbmV4dCA9IGUtPm5leHRfY2FsbGVl
Ow0KKwkgIGlmICghZS0+aW5saW5lX2ZhaWxlZCkNCisJICAgIGUtPmNhbGxl
ZS0+cmVtb3ZlX3N5bWJvbF9hbmRfaW5saW5lX2Nsb25lcyAoKTsNCisJfQ0K
Kw0KKyAgICAgIGlwYV9tZXJnZV9wcm9maWxlcyAob3JpZ2luYWwsIGFsaWFz
KTsNCisgICAgICBzeW10YWItPmNhbGxfY2dyYXBoX3JlbW92YWxfaG9va3Mg
KGFsaWFzKTsNCisgICAgICBhbGlhcy0+cmVsZWFzZV9ib2R5ICh0cnVlKTsN
CisgICAgICBhbGlhcy0+cmVzZXQgKCk7DQorICAgICAgKChzeW10YWJfbm9k
ZSAqKWFsaWFzKS0+Y2FsbF9mb3Jfc3ltYm9sX2FuZF9hbGlhc2VzIChjbGVh
cl9kZWNsX3J0bCwNCisJCQkJCQkJICAgTlVMTCwgdHJ1ZSk7DQorICAgICAg
Y2dyYXBoX25vZGU6OmNyZWF0ZV9hbGlhcyAoYWxpYXMtPmRlY2wsIG9yaWdp
bmFsLT5kZWNsKTsNCisgICAgICBhbGlhcy0+cmVzb2x2ZV9hbGlhcyAob3Jp
Z2luYWwpOw0KKyAgICAgIG9yaWdpbmFsLT5jYWxsX2Zvcl9zeW1ib2xfdGh1
bmtzX2FuZF9hbGlhc2VzDQorCShzZXRfbG9jYWwsICh2b2lkICopKHNpemVf
dCkgb3JpZ2luYWwtPmxvY2FsX3AgKCksIHRydWUpOw0KKyAgICB9DQorICBk
ZWZlcnJlZF9tZXJnZV9hbGlhc2VzLnJlbGVhc2UgKCk7DQorfQ0KKw0KIC8q
IFJlc2V0IGFsbCBzdGF0ZSB3aXRoaW4gaXBhLWljZi5jYyBzbyB0aGF0IHdl
IGNhbiByZXJ1biB0aGUgY29tcGlsZXINCiAgICB3aXRoaW4gdGhlIHNhbWUg
cHJvY2Vzcy4gIEZvciB1c2UgYnkgdG9wbGV2OjpmaW5hbGl6ZS4gICovDQog
DQpAQCAtMzczNSw0ICszNzc4LDUgQEAgdm9pZA0KIGlwYV9pY2ZfY2NfZmlu
YWxpemUgKHZvaWQpDQogew0KICAgaXBhX2ljZjo6b3B0aW1pemVyID0gTlVM
TDsNCisgIGRlZmVycmVkX21lcmdlX2FsaWFzZXMucmVsZWFzZSAoKTsNCiB9
DQpkaWZmIC0tZ2l0IGEvZ2NjL2lwYS1pY2YuaCBiL2djYy9pcGEtaWNmLmgN
CmluZGV4IDQxMzVhZDNlYjljLi5kYWFhMTVlOWQ1NSAxMDA2NDQNCi0tLSBh
L2djYy9pcGEtaWNmLmgNCisrKyBiL2djYy9pcGEtaWNmLmgNCkBAIC02NzMs
MyArNjczLDUgQEAgcHJpdmF0ZToNCiB9OyAvLyBjbGFzcyBzZW1faXRlbV9v
cHRpbWl6ZXINCiANCiB9IC8vIGlwYV9pY2YgbmFtZXNwYWNlDQorDQordm9p
ZCBpcGFfaWNmX2NyZWF0ZV9kZWZlcnJlZF9hbGlhc2VzICh2b2lkKTsNCmRp
ZmYgLS1naXQgYS9nY2MvaXBhLWlubGluZS5jYyBiL2djYy9pcGEtaW5saW5l
LmNjDQppbmRleCBiYThiZjExYjY2ZS4uNzY3MDY4ZTg1ZWEgMTAwNjQ0DQot
LS0gYS9nY2MvaXBhLWlubGluZS5jYw0KKysrIGIvZ2NjL2lwYS1pbmxpbmUu
Y2MNCkBAIC0xMjQsNiArMTI0LDggQEAgYWxvbmcgd2l0aCBHQ0M7IHNlZSB0
aGUgZmlsZSBDT1BZSU5HMy4gIElmIG5vdCBzZWUNCiAjaW5jbHVkZSAiaXBh
LW1vZHJlZi10cmVlLmgiDQogI2luY2x1ZGUgImlwYS1tb2RyZWYuaCINCiAN
CitleHRlcm4gdm9pZCBpcGFfaWNmX2NyZWF0ZV9kZWZlcnJlZF9hbGlhc2Vz
ICh2b2lkKTsNCisNCiAvKiBJbmxpbmVyIHVzZXMgZ3JlZWR5IGFsZ29yaXRo
bSB0byBpbmxpbmUgY2FsbHMgaW4gYSBwcmlvcml0eSBvcmRlci4NCiAgICBC
YWRuZXNzIGlzIHVzZWQgYXMgdGhlIGtleSBpbiBhIEZpYm9uYWNjaSBoZWFw
IHdoaWNoIHJvdWdobHkgY29ycmVzcG9uZHMNCiAgICB0byBuZWdhdGlvbiBv
ZiBiZW5lZml0IHRvIGNvc3QgcmF0aW9zLg0KQEAgLTMwMDQsNiArMzAwNiw5
IEBAIGlwYV9pbmxpbmUgKHZvaWQpDQogDQogICBpZiAoZHVtcF9maWxlKQ0K
ICAgICBpcGFfZHVtcF9mbl9zdW1tYXJpZXMgKGR1bXBfZmlsZSk7DQorDQor
ICBpcGFfaWNmX2NyZWF0ZV9kZWZlcnJlZF9hbGlhc2VzICgpOw0KKw0KICAg
cmV0dXJuIHJlbW92ZV9mdW5jdGlvbnMgPyBUT0RPX3JlbW92ZV9mdW5jdGlv
bnMgOiAwOw0KIH0NCiANCmRpZmYgLS1naXQgYS9nY2MvdGVzdHN1aXRlL2cr
Ky5kZy9pcGEvcHIxMDU0MzgtMi5DIGIvZ2NjL3Rlc3RzdWl0ZS9nKysuZGcv
aXBhL3ByMTA1NDM4LTIuQw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4
IDAwMDAwMDAwMDAwLi42NGFhMzBjNTg4YQ0KLS0tIC9kZXYvbnVsbA0KKysr
IGIvZ2NjL3Rlc3RzdWl0ZS9nKysuZGcvaXBhL3ByMTA1NDM4LTIuQw0KQEAg
LTAsMCArMSwyNSBAQA0KKy8vIFBSIGlwYS8xMDU0MzgNCisvLyB7IGRnLWRv
IGNvbXBpbGUgfQ0KKy8vIHsgZGctb3B0aW9ucyAiLU8yIC1mbm8tc3RyaWN0
LWFsaWFzaW5nIC1mbm8tZWFybHktaW5saW5pbmcgLVdhcnJheS1ib3VuZHMi
IH0NCisNCitpbnQgbG9uZ2VyWzddID0ge307DQoraW50IHNob3J0ZXJbMl0g
PSB7fTsNCitpbnQgb3V0WzEwXSA9IHt9Ow0KKw0KK3RlbXBsYXRlIDxpbnQg
Tj4NCit2b2lkIGNvbmZpZ3VyZShjb25zdCBpbnQoJmluKVtOXSwgY29uc3Qg
aW50IG5yb3dzID0gTikNCit7DQorICAgIGlmIChucm93cyA8PSAxMCkNCisg
ICAgew0KKyAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBucm93czsgaSsr
KQ0KKyAgICAgICAgew0KKyAgICAgICAgICAgIG91dFtpXSA9IGluW2ldOyAv
LyB7IGRnLWJvZ3VzICJvdXRzaWRlIGFycmF5IGJvdW5kcyIgfQ0KKyAgICAg
ICAgfQ0KKyAgICB9DQorfQ0KKw0KK2ludCBtYWluKCkNCit7DQorICBjb25m
aWd1cmUobG9uZ2VyKTsNCisgIGNvbmZpZ3VyZShzaG9ydGVyKTsNCit9DQpk
aWZmIC0tZ2l0IGEvZ2NjL3Rlc3RzdWl0ZS9nKysuZGcvaXBhL3ByMTA1NDM4
LkMgYi9nY2MvdGVzdHN1aXRlL2crKy5kZy9pcGEvcHIxMDU0MzguQw0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwLi5jODRmY2I2
N2I5Zg0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZ2NjL3Rlc3RzdWl0ZS9nKysu
ZGcvaXBhL3ByMTA1NDM4LkMNCkBAIC0wLDAgKzEsMjUgQEANCisvLyBQUiBp
cGEvMTA1NDM4DQorLy8geyBkZy1kbyBjb21waWxlIH0NCisvLyB7IGRnLW9w
dGlvbnMgIi1PMiAtZm5vLXN0cmljdC1hbGlhc2luZyAtV2FycmF5LWJvdW5k
cyIgfQ0KKw0KK2ludCBsb25nZXJbN10gPSB7fTsNCitpbnQgc2hvcnRlclsy
XSA9IHt9Ow0KK2ludCBvdXRbMTBdID0ge307DQorDQordGVtcGxhdGUgPGlu
dCBOPg0KK3ZvaWQgY29uZmlndXJlKGNvbnN0IGludCgmaW4pW05dLCBjb25z
dCBpbnQgbnJvd3MgPSBOKQ0KK3sNCisgICAgaWYgKG5yb3dzIDw9IDEwKQ0K
KyAgICB7DQorICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG5yb3dzOyBp
KyspDQorICAgICAgICB7DQorICAgICAgICAgICAgb3V0W2ldID0gaW5baV07
IC8vIHsgZGctYm9ndXMgIm91dHNpZGUgYXJyYXkgYm91bmRzIiB9DQorICAg
ICAgICB9DQorICAgIH0NCit9DQorDQoraW50IG1haW4oKQ0KK3sNCisgIGNv
bmZpZ3VyZShsb25nZXIpOw0KKyAgY29uZmlndXJlKHNob3J0ZXIpOw0KK30N
CmRpZmYgLS1naXQgYS9nY2MvdHJlZS1wYXNzLmggYi9nY2MvdHJlZS1wYXNz
LmgNCmluZGV4IGEzYjM1ZTAwOWUwLi5iZGQ2MGY3MmQ4MSAxMDA2NDQNCi0t
LSBhL2djYy90cmVlLXBhc3MuaA0KKysrIGIvZ2NjL3RyZWUtcGFzcy5oDQpA
QCAtNTM5LDYgKzUzOSw3IEBAIGV4dGVybiBzaW1wbGVfaXBhX29wdF9wYXNz
ICptYWtlX3Bhc3NfaXBhX2ZyZWVfZm5fc3VtbWFyeSAoZ2NjOjpjb250ZXh0
ICpjdHh0KTsNCiBleHRlcm4gaXBhX29wdF9wYXNzX2QgKm1ha2VfcGFzc19p
cGFfY3AgKGdjYzo6Y29udGV4dCAqY3R4dCk7DQogZXh0ZXJuIGlwYV9vcHRf
cGFzc19kICptYWtlX3Bhc3NfaXBhX3NyYSAoZ2NjOjpjb250ZXh0ICpjdHh0
KTsNCiBleHRlcm4gaXBhX29wdF9wYXNzX2QgKm1ha2VfcGFzc19pcGFfaWNm
IChnY2M6OmNvbnRleHQgKmN0eHQpOw0KK2V4dGVybiB2b2lkIGlwYV9pY2Zf
Y3JlYXRlX2RlZmVycmVkX2FsaWFzZXMgKHZvaWQpOw0KIGV4dGVybiBpcGFf
b3B0X3Bhc3NfZCAqbWFrZV9wYXNzX2lwYV9kZXZpcnQgKGdjYzo6Y29udGV4
dCAqY3R4dCk7DQogZXh0ZXJuIGlwYV9vcHRfcGFzc19kICptYWtlX3Bhc3Nf
aXBhX29kciAoZ2NjOjpjb250ZXh0ICpjdHh0KTsNCiBleHRlcm4gaXBhX29w
dF9wYXNzX2QgKm1ha2VfcGFzc19pcGFfcmVmZXJlbmNlIChnY2M6OmNvbnRl
eHQgKmN0eHQpOw0KLS0gDQoyLjUxLjANCg0K

---1475677436-904524837-1792054693=:5350--

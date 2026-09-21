Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF152EEE67;
	Mon, 21 Sep 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972759; cv=none; b=d3yVLwDVZ2wOMLUwQ+FGjPOvzAmqRycoAl6eGimvrW4zXuF9Paoe4zmzbXzubshdHYTicrhgXrJAoB3G2287i8N0sB6SN/OSiliOND9AVGlL3dHciggcu0/ZXDn4oOfHBpAnn+mB6Ae0poAirxzsKMtlr7+2EVFTIkZ7KJvMXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972759; c=relaxed/simple;
	bh=NaISpYsHMEZBjRuJVGOqDl6OVc79Bis1jd6WaCc/MEQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=QgfP/kwRZJSP+S81CzxoIgFLHrp4P4W0lUu6Xw2pPgrSj4CgjNj2sQcBiCnDEg19Sn0StcW0tAHJEGjecMNk+1rBtnc/Awn2d2bm/NvUBlfmlpjVhzEzSPOzBLOMSaZXMhMl6YN6ClT71jW4RXt+0tJbKqOr8O/enqelRK2qoE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UsucVU+g; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UsucVU+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789972746; x=1790577546; i=markus.elfring@web.de;
	bh=NaISpYsHMEZBjRuJVGOqDl6OVc79Bis1jd6WaCc/MEQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UsucVU+gp24c8i4RQlQr3BUHKM1FbkpNLdcUhXH5240/FXwqGPFb1/KhOyiazZA7
	 n0FsTkTpZ+YZBz5QjOv9je+yYa0j4OuE3pxQo9uRYKBh4vX6DpEhk3L30ZEErcByT
	 1TL8iPWaq0PSa/IJGM2UqB+8nzEVkRm+hKRUg5Ldogpz4YtjtYN2vSXWdNlYQV8Ni
	 BOsena/OcgUY1oC03TTNMlSRYDLLUT1LGUBzRHaV3xJ/Er+4vgK1Vbfwib1acSdvQ
	 0tzdFZB4xhqkdG3VjnYUNAQUcd6qFQ7PO2VwhlLNBAb5NvJ7CHLULLDZqo66Txgcg
	 rEevE1Q6ljfYGAZ6eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SKz-1wm6z83MB5-016TVc; Mon, 21
 Sep 2026 08:39:05 +0200
Message-ID: <0562677e-2811-4ccb-bcd5-b00583724612@web.de>
Date: Mon, 21 Sep 2026 08:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] Referencing local variables with SmPL?
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Language: en-GB, de-DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+rl9oiJ67cIN59raX4fWyJQ/sL/Qhr26D93qOkqaubw6hVfvyeu
 SEYcVRgb0zcfH9vAA61wYNZ0DQfLPI6KJwxofbahq0avej+8wmbom0mym6qQfdWxxHVE82Y
 MxqgVasWmgoSby84kcAaPqDs4y2O2BfJD8luLw4ath41T8JnfM8VPdfu9KgoaA4lA/mYOUX
 qY9QZ3ByVjkRsUy10UA8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QmJOmetLWpg=;V6J0qY6gPgtjU4gJSsOKi0K9Blh
 X+5IgLXIi1auHCWSSwv/qJgvZtZrSB2+QkZy+yM7xYr/Tq65WUyf5E0P5A/+BOdPu97oEUM1g
 t6WfnqBFJwhcZ0UGUAwmIa6u9mQkcd6g8cmI4200MQrqOo+hqKDPl9n5cI9ykGzf4vx72MnK/
 o/mFB9/2442J5nXa1d80xpYV5fx3G62ly69KX5mnErpEAzDG8/UVxFYKdieU9Ke7naBVpLiTF
 1mzvnlpPALkBsufdDv3e+PfrlqhhHdyOlXPtQYpGhUPtPAvnw3y6nlD585vOvfrNXMsfUbTPI
 1e/xSGn3WsUtst9kh6Jt8zzMtofeTsnxK/MAUY7ytpKDq7c+6UHDJoxGH43h2fxz7K+uR2Hto
 KPPZym+fXAWVNUyPDMN9FzVOIEpUekEUEzgXYrBzxYPERzyN2OmyC6iqxgoHeIbwZD38mZwk7
 67L+Kt3IeWrBfVSTz47Miq605qEP+I7x0/UvStPSfTLhNDwtOsmci89Lm2Cbx5pEJF7xt8LPW
 xlhM19lIhwTNsP1lLxw4Tdky1msSPPxoWvxWny42VpF5V5+HGN+zG+2B7MOPqcNcxvhOzPjuR
 YW/ukXjrAHcXTBkqYpU2YJCJStkcoRvDWL6dWbHNzkk7GsZNnRc1T9pMZBu1COkw9dHYxdAv6
 0Zq7jR7n+6+QnU/UU38qhhwYAZ0DOnrD1XPfdbx4CFXOzlC1hAtxwxGWN4JCVepuW8nU3IG8Z
 /PhHSv0BL4jQdICICilCfwZjxUobhC03QTetycYfcXNE0NNOdHEwJSSz905zocqDMDWhRB9Cx
 4pcwzLlv5eMWdCUfFtLMgRG5nx3BQ+g2UPjIOFX0lTXZW+4j9eO2ripOHi6LDuCiVW617Q1nj
 SxUo6v48l4+RzPK8iaWv1KfJSPhBJHfNJ/qHRv+MstiodDWJ1ZUrfZpPPoXpbauwNj/zOa8W2
 2GcRSHRz29uhoe5wIb7F42QOnvc7xG+hMe53rV7Q+c3nf0qhS38KIu8RxutEokHUNsch7gwUb
 Lxy/oKikacGsoxL0JT3laHFSfX3qzN7kC3FWaQpwbQaQ1mDoeHj0ASOu3F7DQCz36bbs5Gz8H
 fTP6CxLwjYIc9/jpB2PB0Ft5oFyzgr95m9/HwfeDl917N7JFTNgyt+1aehbOunTUOHT0DKpkA
 lB3+n00ATwL8wJ413g5r97LsCeaOUQF/1+4xG+JhyLtbJl/JzrL/O4YiBbEsUZxhrOupYAaJx
 ODN/j0KkiRc/t11nTbtiEBurIjtiKiGKUqlzKRruXc05kgQsK9QN5qBmmssrwK0iGmkeHQjtv
 Rc9y6dUIdoFipu8HLB8gx/PS8+nTbTDxSziXiFJivC+chvf9uvXYfyv0LJqg2sPggJ4/lR3VY
 uu2tMGKL5I1aWwvH7zOD7OLa2sVYfUwPC/a+8GnnTM7l8vFgeg5lmWHr2lXhe2iksnaCl+7uL
 hK8h55dcloqvI9ygmbn/nOI+blKHzF6kAasexhmvZawLq3HQGXV5BRFjwMAJxqWMPFqw2qGGx
 VXL3j2Unn9cFDd5s7uBM9j35AEQUmiOuy6YinBOYXyZyXWU//fcWU9PJ6J5h3Fv+lBEDP+r5P
 IbBu11e6TH2/Dl6HGq+VJSfZg+xOqHUvUReMYIcp/13eTSQvoUhfR80alkVDysEJ6bVBQMk9N
 ZcKr6d45eYSPyGXqQnD3rPDOKHJ8QFJrZUopSrfPXtjLPfx2HePmZFB0uGUe9bxqXEhuOg3YG
 t78yN9569pjOvqvvSm2tv/MLzpB67SuTOUpDfvPz95q2y+GaUUENVyg1J53MaGt2R/pGNRTxS
 QfNWD9NbTb6LZhnGeHZ68b8YPMD/hg+xIWBHsNCwMdK+ACoif7iHU60BJ8henfqXo7rgoFOEe
 aOfdSqYY3MuCjq5fwZuz6o0TN6bkqVEAcpWwqdQMflEjRjLG/dR/bMODF/7Z3CySW3hU5eCnn
 nbuIiz+eZARxfSNvI1jZH48+Sn0vyHZcuWb4pYkOti2XrdWjQWB71P4FXZXZU8Iv9vNuaN3Ye
 lRHV8Vgh4bm8Kx4Ogde4xiUlRS0TKZz4ZpVEQxEYfZdRvdT/nRLR5X44zgKLeR4HzFwaVtAQI
 PT1WKHiCO29CDrvekGq0ZIiqsCkTy16cvLs9bxysefkFcJtqGV+23O7AMbyJEv26NzpoPVkgy
 2h38ZZiiIzUj/UgQ6aUQaPa4mIcqJOQ2Bvhjcnwbe4GOHP+dnSYhxRY82hRamOzTn0WBPZpjd
 9klNuTJ8OczT5NEBr4fcibGCZFkBG/+1Dgt7c2xTYKQQISNsJ4XCoDhN/F5rFbccBUs0Y+4tT
 YOqKCbQ6zXeJU8nVkgqfOCfpe4dLmbsBkzBvRvL1COz0KDpZ3x/eIQqWYvp58Q4JJ7NfPl8uD
 CSF+Ls4SipJrP1IT/5/OwrMQfzOW5FPKg7Csj+VdsEGoGGCGRBltM8tkVFhIU/s37HlN56yEZ
 FcmZbxsnRh4sW1vJVNu4ctFnD1alSV8sZwXgDFKhop7jV4eIZYcCRRMivGqeFPgZH3kcv2tv+
 7bVI2bFA8GnVgt9JKg+i/w+9G+6V+M5S2noGtIwrH6pjG5uLNYEk2emDQVMVDRCPSpTVK1xMp
 HjEI0AZnq7Sm4Z1j0xm4ojjDe3gr+pyXJ1VdcJOug2pc6oeo0WfWjtc0BAA3E5ADWAvyQA39n
 4i7j6rX1hB6nLGX6CYadCrydTDPZi/diO+vb0c69hickzHaCatwFV2qBYMrp03jiP5AZ3U20V
 +rYXbxIGuLkwMwLqKoR3d4FGsgnQFUiRLFn29IL/MvnJVS3gtysFI73Rc0329lHIDu71OKmok
 Lt5Jwk5XNvnEv8E6hvU77U3YV7U/gMEtC5EOtZBkbzNSJKVkUVdhij112xa5w0brCCeAgB+V/
 HM15PlHTq9Zj4zzprdsa6wxBOVeglinEyf7MLLCu9kRDfQZhnXZEL0mWHFTml7xmKn+aJheHW
 lrHhCD7BYiQi2VdsQd/XlrUtqvrJmzWU0m+NZ9X08bcTwRinnlB3363Z1FBa54YEkwVBDbtpY
 NzHU5DuuHhAFWyWEvFWG4WWDun4aRVb1hoWdy1DjvUJ73exVq5JAxDJn8B3ZdEAEithwTq95B
 L00ufJssdYf/8ddJDMsfRyZ3W4JC+yB0hkgB2ifRlDSc831onLmeOHaUCEd1jzTLE4psx3zxY
 JSiZymrgqYqYzkMO4mgWWA7/5MRpJ+AclQ5JpKQ2NC5b/Iohunofr3maYD85YnQjaABfpZJKj
 2EoASOoEyY34oObK21Lrx8E5LNPsaZDnB+y6Z+toiQuLtW0D7i+EuULktq5sPa/2k9ftxyDba
 0xSr89FKJhpvvc4pojF/7eeRiNggLxsOL23pT3f5WSrsIOyjp5uPXx/oo7zpR/nYkUnNPxWbj
 eep2luyK3v7vRDygsiLbcsVGCnfIdlSIGD5fIt+bXdMdTQqCY4aY+/jvYAT4mhQY9N3lXFAXs
 ITSF7SxbSorrR4MZ14ninIIavB5A6w21kwAodbkIHZgpm1li6k4+u+V0oDONdlqmbYLRhJqQa
 DDNi3mqeqyNXb8UzZEQZQOrxkINT2mM1U3rL0UvuHom+LRXZnx4DbY2ecJ8lahsV3ImzSG5+4
 dGUZA1lElGwkqLiDvp1IoV0J7J94JPlfykEiQg4FLGfMiCAxnuIXw/lnkE0LhkZyqg1CpxSKH
 OkWM6WiZAMB0tMtsmWl8hATgvH+yBk+kocnrwJ04OeCG708LniOg+pq/qgP2G5oYyK+vMIOfc
 z/e7Fqi8NyHqZlzxAhPGh8r+xyD8pPvLC9KvCvNrLHZdNEzWeWTwK1OrffyFwsUJzNy/PHnty
 GL6UIZXiSQeZqkzhBp7VeZJ2cD+b4GfZ7ERKBKVNUDAt8dHACSXqG3Za+bznQHTMfY+N96ZcG
 Emp3Odh9Ede4BC3zQdC6N8wJJi8eQZ0KynUDfS3LZAWsAGrdecX4/75I5FXHSBl+FQWq0yT++
 a8HEiuCZKB0gIt+jdyXgbgvoZLZwy175w7ww3XL9bLcgsq+hhDZ9jtY5UCzM52PyCuNU8/j2z
 5CdDrta6ctJco6YE/bqazz4JmfsWtFkIEubEsqn40ekEC9XDLcLXTgnCy27c8HOVAnjaC4fxm
 /er4L/nv3IjZVxcVmRVZybURGB0FVPh75SqocT1AdYaLnUqXCg+N7MUvJfDO6UTRKpJIhSssg
 Qk0NLx6g/p6amJk+ccitITY4Wc1R45oYN7PhyvpFnzSKhDJ0XguYBd+aRycC69ldXZ0xkM1kw
 Iryo+c+uCfv63LUtjbqGS+NB/hDnLHUdWufH3Fmdi6glKjxmu+f7rcsEwbDWfq9Kt+b/4MCOs
 9K+kHRXkJnvR8vtYpLuClF48ISQQjc2/nDc/GHttSuaYQAR6E3SgeSkjchH0/eu5LuzWY7jO/
 FntwCB2mFNAMQ46DtMZ6CcslucAX6mLcp7ZHhAxP4tLwiDo1IcIW5yB646cUqgi0qqJBKzm7p
 Bpmt4nyEL2Q6aPkbgE0gL4ZmLb4xAucVueqEzV8zuZsNODPOuBuMcNCzGVFwG68HoZvVtgIsd
 Vtsdff+KSlB1ZSgwZJnSSDc7vEiJchRGvMfQ3HoRaLpWQNO3zA0jmMcOLbFi246rttVNw5PGT
 Vo1qd0BY51ZkTGzfl5kJav20LeCx3XTmyXhIoepkRxl8fl1Aifn/LIQlChAiVjsb4AwOHn5Yt
 VcAycYEzKuQsqddAJWShQehjpyJCFzMPNJEvFA6lYALUPyNGwPXYuUgz1Aa5aOYfQIc8qCfrI
 GGQWpn29JMzKifqOklAGbhv4PDxyunRQmy2iLaUCPlGeM/wiYRPBZWzDGLfV6NsNJ7uQxn04S
 X3s/pR2jvIsZwuHNyiiln6UiuMR3Qd+1uznFDekUUrxyuVfHReiduPJ1W8MyTTz0CGQmgZ0/e
 CmBWgDKUvzGnYUm8OF1koW6DRvIsJ1cbtBMzyDesIBfRuRmEwR9jvlWV5I18+QIRlsOFW9rUc
 TBSMRVuGLIclO0Ts261qbFMcPtgVTo1XzHmTOyIuItXbj10ucM1fh0NF/qcNwDj/evXOKqhed
 NYFlHo71Y/+9NUe2x9WN0sMNGCSYVyAD135up+NM7q0Kn7yPZ+v/O4fsAnQ2zriDwnRZGxXPx
 8RBAKUPbzQ9XjV9Fpm9Q4xF/eEb+sqSyRVOsfYGbQI/s6KThzPwCIT80Dug1b+L3XfgJsvlSq
 14EQyf+rmErRKS3oY8sCpAtsOyfCVKaHJqs1jVN3G1ORva4jUGq2d6l3AN40BnEz5YhDlKpBr
 Wo3UAodhcRYTWoDZCDxZRFwQ02yoQUtoQWLy9B7mzrysWDIST9HZPgYHQazWhz+OrXRb2Iqe+
 hgZPBcRqCBFAL6ODQcIWqNpltJ2fkE9+HcW/bgqFssh1yuDFicl9zvbe6K38GXHZJZM+UwRkf
 pjqpuzbPqQfMlLY8183/zEospJVLWh+Z3FdAw+X3HBYTfV1i8klqQ8Sigm/bINBcxvolVmyLG
 dr2f0+/hGOs9f5kay4/UoPsou9xvhchgeGUdxxxZXq58xR1R4rfw5+MZGLkCWT4tWAGGxXXvI
 pIAbKky3b4soTYRjNA7Py45vKOIeXpWck8esfSPYPqLIxTqYnuKi/rDWPiT2FHp4j5XZgvTSn
 Cq7LGygEAfVXudwwYYrOzbNEVp4eWKMD3QXLwaOvCNlFYoVC9XfdojIRTbGAzOKdBz00zzen1
 6db9PFoIG03F3MlCwmVjFQa91Ltz5sizmPgTKtAWO7fD+YC3uh57SQZTbVbST69eHOw2AhouZ
 NjuO4ZXsu3qxkga19Jwp/3rAEyl7+jqD0JToJ2TWsL9eHnXqhqRhU7tNQO2S/kTKxLoELzb0D
 Mfx6lWVOmkNOyl806VHWba7cNxgs7Yk3mVsU9OTac16kpvHOm3HCVHm0vhT6qYmpo6MyexCr0
 ZcfTm5aoAZ6+wfIl9ZGrbW9g3H959VcG4rg01SspkKHK5Ta5JEDhsV+5wc8py8yPQbpZYco5q
 Oko8mWn4AzkEJkTj6nOjhA/xwaMlq0HXLpswFHZhDJA+8IZUKwxqCWXeXqKsoJpUQWS5lWRN9
 ItKnEQphxTPgRoL9BAjxWUiHn+r0cMLzasFBJp8YpAqlG68p6X8+42eLwcyojohumEDLbU+91
 kUdafmMMLY9rvpiaDpnDKaAzP/lqD7ixHx628ba3goYWHCHoYk35ikRoatxQXA==

Hello,

Declarations (and definitions) of local variables tend to be required
for various control flows.
https://en.cppreference.com/c/language/declarations

Function implementations can occasionally use multiple variables with different scopes.
https://github.com/coccinelle/coccinelle/issues/322

Thus it seems to be challenging to refer to relevant data specifications
in a consistent way for source code search and transformation approaches also
by the means of the semantic patch language.
How will corresponding development ideas evolve?

Regards,
Markus
